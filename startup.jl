using WebDAV


if isfile(expanduser("~/.test_webdav"))
   ENV["WEBDAV_USERNAME"],ENV["WEBDAV_PASSWORD"],ENV["WEBDAV_URL"] = split(read(expanduser("~/.test_webdav"),String))
end


function default_WebDAV()
    if haskey(ENV,"WEBDAV_PASSWORD")
        username,password,url =
            ENV["WEBDAV_USERNAME"],ENV["WEBDAV_PASSWORD"],ENV["WEBDAV_URL"]
    else
       error("Env. variable WEBDAV_USERNAME WEBDAV_PASSWORD and WEBDAV_URL must be set")
    end


    return WebDAV.Server(url,username,password);
end


"""
    filename = get(remote_filename,local_filename = tempname())

Download `remote_filename` from WebDAV and store it at `local_filename` (or per default a temporary random file name).
The environement variables `WEBDAV_USERNAME`, `WEBDAV_PASSWORD` and `WEBDAV_URL` must be set.
"""
function get(remote_filename,local_filename = tempname())
    s = default_WebDAV()
    download(s, remote_filename,local_filename)
    return local_filename
end


"""
    put(local_filename,remote_filename)

Upload file `local_filename` at `remote_filename` from WebDAV.
The environement variables `WEBDAV_USERNAME`, `WEBDAV_PASSWORD` and `WEBDAV_URL` must be set.
"""
function put(local_filename,remote_filename)
    s = default_WebDAV()
    upload(s, local_filename, remote_filename)
    return nothing
end
