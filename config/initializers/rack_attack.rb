class Rack::Attack
    throttle('req/ip', limit: 300, period: 5.minutes) do |req|
      req.ip
    end
  
    throttle('login/ip', limit: 5, period: 20.seconds) do |req|
      if req.path == '/api/v1/admin/auth/login' && req.post?
        req.ip
      end
    end
  end