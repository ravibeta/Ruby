# encoding: utf-8
require 'net/https'
require 'uri'
require 'json'

class Share
  @uri = URI.parse(URI.encode('https://localhost:5000/api/v1/exports/'))
  @http = Net::HTTP.new(@uri.host, @uri.port)
  @http.use_ssl = true
  @http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  def self.list()
        request = Net::HTTP::Get.new(@uri.request_uri)
        response = @http.request(request)
        return response.body
    rescue
        return ''
    end

  def self.create(newfolder)
        data = {'title' => newfolder , 'path' => newfolder}
        puts data.to_json
        json_headers = {"Content-Type" => "application/json", "Accept" => "application/json"}
        response = @http.post(@uri.path, data.to_json, json_headers)
        return response.body
    rescue
        return ''
    end

  def self.delete(newfolder)
        data = {'title' => newfolder , 'path' => newfolder}
        query_string = URI.encode_www_form(data)
        puts query_string
        json_headers = {"Content-Type" => "application/json", "Accept" => "application/json"}
        response = @http.delete(@uri.path + "?" + query_string, json_headers)
        return response.body
    rescue
        return ''
    end

  def self.modify(params)
        json_headers = {"Content-Type" => "application/json", "Accept" => "application/json"}
        response = @http.put(@uri.path, params.to_json, json_headers)
        return response.body
    rescue
        return ''
    end

  def self.modify(params)
        json_headers = {"Content-Type" => "application/json", "Accept" => "application/json"}
        response = @http.put(@uri.path, params.to_json, json_headers)
        return response.body
    rescue
        return ''
    end

  def self.test(mynewfolder)
        puts self.list()
        puts self.create(mynewfolder)
        puts self.modify({"location"=>"sjshare","sharename"=>[mynewfolder],"rootsquash"=>"off","user"=>"rajamani","group"=>"wheel","userperm"=>"7","groupperm"=>"0","everyoneperm"=>"0","readhost"=>["10.0.0.1","10.0.0.2"],"writehost"=>["10.0.0.3","10.0.0.4"],"roothost"=>["10.0.0.5","10.0.0.6"],"hardsize"=>"12","advisorysize"=>"8"})
        puts self.delete(mynewfolder)
        puts self.list()
    end
  end

Share.test('mynewfolder')
