# frozen_string_literal: true

require 'socket'

# INET DGRAM ( = UDP)
def inet_dgram(port, host: '0.0.0.0')
  Socket.new(:INET, :DGRAM).tap do |socket|
    socket.bind(Socket.sockaddr_in(port, host))
  end
end

# INET STREAM ( = TCP)
def inet_stream(port, host: '0.0.0.0', backlog: 64)
  Socket.new(:INET, :STREAM).tap do |socket|
    socket.bind(Socket.sockaddr_in(port, host))
    socket.listen(backlog)
  end
end

# UNIX DGRAM
def unix_dgram(file: '/tmp/unix_dgram.socket')
  Socket.new(:UNIX, :DGRAM).tap do |socket|
    File.unlink(file) if File.exist?(file)
    socket.bind(Socket.sockaddr_un(file))
  end
end

# UNIX STREAM
def unix_stream(file: '/tmp/unix_stream.socket', backlog: 64)
  Socket.new(:UNIX, :STREAM).tap do |socket|
    File.unlink(file) if File.exist?(file)
    socket.bind(Socket.sockaddr_un(file))
    socket.listen(backlog)
  end
end

# UDPSocket ( = INET DGRAM)
def udp(port, host: '0.0.0.0')
  UDPSocket.open.tap do |socket|
    socket.bind(host, port)
  end
end

# TCPServer ( = INET STREAM)
def tcp(port)
  TCPServer.open(port)
end

# UNIXServer ( = UNIX STREAM)
def unix(file: '/tmp/unix_server.socket')
  File.unlink(file) if File.exist?(file)
  UNIXServer.new(file)
end

sockets = {
  inet_dgram: inet_dgram(1190),
  unix_dgram: unix_dgram(file: './unix_dgram.socket'),
  inet_stream: inet_stream(1191),
  unix_stream: unix_stream(file: './unix_stream.socket'),
  udp: udp(1192),
  tcp: tcp(1193),
  unix: unix(file: './unix_server.socket')
}

loop do
  res = IO.select(sockets.values)
  res&.first&.each do |sock|
    case sock
    when sockets[:inet_dgram], sockets[:unix_dgram], sockets[:udp]
      p '--dgram----------------'
      p sock.recvfrom(1024)
      p '------------------'
    when sockets[:inet_stream], sockets[:unix_stream], sockets[:tcp], sockets[:unix]
      client, from = sock.accept
      data = client.recv(1024)
      p '--stream----------------'
      p from
      p data
      p '------------------'
      client.puts 'OK'
      client.close
    end
  end
end

sockets.values.each(&:close)
