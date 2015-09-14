<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#sec-1">1. Files</a></li>
<li><a href="#sec-2">2. API description</a>
<ul>
<li><a href="#sec-2-1">2.1. directory</a></li>
<li><a href="#sec-2-2">2.2. tips</a></li>
<li><a href="#sec-2-3">2.3. users_controller</a>
<ul>
<li><a href="#sec-2-3-1">2.3.1. show</a></li>
<li><a href="#sec-2-3-2">2.3.2. create(register)</a></li>
</ul>
</li>
<li><a href="#sec-2-4">2.4. sessions_controller</a>
<ul>
<li><a href="#sec-2-4-1">2.4.1. create(login)</a></li>
</ul>
</li>
<li><a href="#sec-2-5">2.5. virfiles_controller</a>
<ul>
<li><a href="#sec-2-5-1">2.5.1. index(list all the files in the directory)</a></li>
<li><a href="#sec-2-5-2">2.5.2. create</a></li>
<li><a href="#sec-2-5-3">2.5.3. show</a></li>
<li><a href="#sec-2-5-4">2.5.4. destroy</a></li>
</ul>
</li>
<li><a href="#sec-2-6">2.6. test hello</a>
<ul>
<li><a href="#sec-2-6-1">2.6.1. description</a></li>
<li><a href="#sec-2-6-2">2.6.2. request and response</a></li>
</ul>
</li>
</ul>
</li>
<li><a href="#sec-3">3. Security</a>
<ul>
<li><a href="#sec-3-1">3.1. XSS(Cross-Site Scripting)</a></li>
<li><a href="#sec-3-2">3.2. CSRF(Cross-site request forgery)</a></li>
<li><a href="#sec-3-3">3.3. SQL injection</a></li>
<li><a href="#sec-3-4">3.4. Mass assignment</a></li>
<li><a href="#sec-3-5">3.5. Filter sensitive information</a></li>
</ul>
</li>
</ul>
</div>
</div>

# Files<a id="sec-1" name="sec-1"></a>

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="left" />

<col  class="left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="left">Name</th>
<th scope="col" class="left">Description</th>
</tr>
</thead>

<tbody>
<tr>
<td class="left">README.org</td>
<td class="left">this file</td>
</tr>


<tr>
<td class="left">base_controller.rb</td>
<td class="left">base controller</td>
</tr>


<tr>
<td class="left">sessions_controller.rb</td>
<td class="left">log in</td>
</tr>


<tr>
<td class="left">users_controller.rb</td>
<td class="left">user create, show</td>
</tr>


<tr>
<td class="left">virfiles_controller.rb</td>
<td class="left">The file system that user could access</td>
</tr>
</tbody>
</table>

# API description<a id="sec-2" name="sec-2"></a>

## directory<a id="sec-2-1" name="sec-2-1"></a>

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="left" />

<col  class="left" />

<col  class="left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="left">url</th>
<th scope="col" class="left">description</th>
<th scope="col" class="left">Methods</th>
</tr>
</thead>

<tbody>
<tr>
<td class="left">/api/v1/users(.:format)</td>
<td class="left">register a user</td>
<td class="left">POST</td>
</tr>


<tr>
<td class="left">/api/v1/users/profile(.:format)</td>
<td class="left">show user's profile</td>
<td class="left">POST</td>
</tr>


<tr>
<td class="left">/api/v1/sessions(.:format)</td>
<td class="left">user login</td>
<td class="left">POST</td>
</tr>


<tr>
<td class="left">/api/v1/virfiles(.:format)</td>
<td class="left">create file or directory</td>
<td class="left">POST</td>
</tr>


<tr>
<td class="left">/api/v1/virfiles/index(.:format)</td>
<td class="left">list all files in the directory</td>
<td class="left">POST</td>
</tr>


<tr>
<td class="left">/api/v1/virfiles/show(.:format)</td>
<td class="left">show all the  frags of this file</td>
<td class="left">POST</td>
</tr>


<tr>
<td class="left">/api/v1/virfiles/delete(.:format)</td>
<td class="left">delete a file</td>
<td class="left">DELETE</td>
</tr>


<tr>
<td class="left">/api/v1/hello(.:format)</td>
<td class="left">test hello</td>
<td class="left">GET</td>
</tr>
</tbody>
</table>

## tips<a id="sec-2-2" name="sec-2-2"></a>

-   The token would  be changed after 3 times error
-   Please change all the "http://localhost:3000" into "http://222.195.92.170:3000" (It could be changed frequently)
-   The root directory for every user is nil string ("")
-   Every method to operate the virfile have to be verified at the very beggining. We have to receive {verify_info, :user_name, :authen_token}. 403 error for wrong authen_token

## users_controller<a id="sec-2-3" name="sec-2-3"></a>

### <a id="userShow" name="userShow"></a> show<a id="sec-2-3-1" name="sec-2-3-1"></a>

1.  description

    -   show the profile after verify.
    -   POST   /api/v1/users/profile(.:format)
    -   400 for error name & 403 for error token

2.  request and response

    -   request  {"show_user" : {"name" : <name>, "authen_token" : <token>}}
    -   response {"user" : {"name" : "abc", "register_date" : "2000-01-01"}}

3.  e.g.

    -   error e.g.
        -   curl -s "http://localhost:3000/api/v1/users/profile" -X POST -H 'Content-Type: application/json' -d '{"show_user":{"name":"test00", "authen_token":"token"}}'
        -   403 error
    -   successful e.g.
        -   curl -s "http://localhost:3000/api/v1/users/profile" -X POST -H 'Content-Type: application/json' -d '{"show_user":{"name":"test00", "authen_token":"token"}}'
        -   {"user":{"name":"test00","register_date":"2015-07-20"}}

### <a id="createUser" name="createUser"></a> create(register)<a id="sec-2-3-2" name="sec-2-3-2"></a>

1.  description

    -   register a new user
    -   POST   /api/v1/users(.:format)
    -   Meaning of state:
        -   -1  |name| < 3
        -   -2  |password| < 6
        -   -3 user already exist.
        -   0 no error

2.  request and response

    -   requst {"register_user" : {"name" : <name>, "password" : <password>};
    -   response {"state" : 0, "user" : {"name" : "abc", "register_date" : "2001-01-01", "authen_token" : "hellodks"}}

3.  e.g.

    -   short password e.g.
        -   curl -s "http://localhost:3000/api/v1/users" -X POST -H 'Content-Type: application/json' -d '{"register_user":{"name":"test0", "password":"12"}}'
        -   {"state":-2}
    -   short user name e.g.
        -   curl -s "http://localhost:3000/api/v1/users" -X POST -H 'Content-Type: application/json' -d '{"register_user":{"name":"t", "password":"12345678"}}'
        -   {"state":-1}
    -   successful e.g. 
        -   curl -s "http://localhost:3000/api/v1/users" -X POST -H 'Content-Type: application/json' -d '{"register_user":{"name":"test00", "password":"12345678"}}'
        -   {"state":0,"user":{"name":"test00","register_date":"2015-07-20","authen_token":"135"}}
    -   duplicate name e.g.
        -   curl -s "http://localhost:3000/api/v1/users" -X POST -H 'Content-Type: application/json' -d '{"register_user":{"name":"test00", "password":"12345678"}}'
        -   {"state":-3}

## sessions_controller<a id="sec-2-4" name="sec-2-4"></a>

### <a id="login" name="login"></a> create(login)<a id="sec-2-4-1" name="sec-2-4-1"></a>

1.  description

    -   login and get user information & token
    -   POST   /api/v1/sessions(.:format)
    -   *login_suc = true* if success.
    -   *user = nil* when *login_suc == false*
    -   401 error if login fail

2.  request and response

    -   request {"user" : {"name" : <name>, "password", <psw>}}
    -   response {"login_suc" : true, "user" : {"name" : "abc" , "register_date" : "2001-01-01", "authen_token" : "askgs"}}

3.  e.g.

    -   successful e.g.   
        -   curl -s "http://localhost:3000/api/v1/sessions" -X POST -H 'Content-Type: application/json' -d '{"user":{"name":"test00", "password":"12345678"}}'
        -   {"login_suc":true,"user":{"name":"test00","register_date":"2015-07-20","authen_token":"abc=="}}
    -   fail e.g.
        -   curl -s "http://localhost:3000/api/v1/sessions" -X POST -H 'Content-Type: application/json' -d '{"user":{"name":"test00", "password":"123456789"}}'
        -   401 error

## virfiles_controller<a id="sec-2-5" name="sec-2-5"></a>

### <a id="fileIndex" name="fileIndex"></a> index(list all the files in the directory)<a id="sec-2-5-1" name="sec-2-5-1"></a>

1.  description

    -   list files and directory under "path" of "user_name"
    -   POST   /api/v1/virfiles/index(.:format)

2.  request and response

    -   request {"abs_path" : {"user_name" : <name>, "path" : <path>, "authen_token" : <token>}}
    -   response {"list" : [{"name" : "a", "if_file" : true}, {"name" : "b", "if_file" : false}]}
        -   list is an array, its element is virfiles(:id, :name, :if_file)
        -   *if_file == true* means that it's a file, a directory otherwise.

3.  e.g.

    -   root directory
        -   curl -s "http://localhost:3000/api/v1/virfiles/index" -X POST -H 'Content-Type: application/json' -d '{"abs_path":{"user_name":"test00", "path":""}, "authen_token":"h67w=="}'
        -   {"list":[{"name":"first","if_file":true},{"name":"firstd","if_file":true},{"name":"firstd1","if_file":false}]}
    
    -   normal directory
        -   curl -s "http://localhost:3000/api/v1/virfiles/index" -X POST -H 'Content-Type: application/json' -d '{"abs_path":{"user_name":"test00", "path":"firstd1/"}, "authen_token":"OmWA=="}'
        -   {"list":[{"name":"secondfile","if_file":true}]}

### <a id="listFile" name="listFile"></a> create<a id="sec-2-5-2" name="sec-2-5-2"></a>

1.  description

    -   POST   /api/v1/virfiles(.:format)
    -   create a new file or directory under "path" of "user_name"
    -   the new file or directory would be "path/file_inf.name".

2.  request and response

    -   request {"abs_path" : {"user_name" : <name>, "path" : <path>}, "file_inf" : {"name" : <name>, "frag_num" : <num>, "if_file" : <if_file>, "file_sha1" : <sha1>, "file_md5" : <md5>, "frag_arr" : [array of frags]}, "authen_token" : "token"}
        -   if_file == 1 means it's a file, otherwise a directory
    -   response {"sec" : true}

3.  e.g.

    -   fail create
        -   curl -s "http://localhost:3000/api/v1/virfiles" -X POST -H 'Content-Type: application/json' -d '{"abs_path":{"user_name":"test00", "path":""}, "file_inf":{"name":"ff2", "frag_num":2, "if_file": true, "file_sha1":"123", "file_md5":"123"}, "frag_arr" : [{"addr":"www/baidu/com", "index":1, "sha1":"123", "md5":"123", "server_name":"xinlang"}, {"addr":"www.google.com", "index":2, "sha1":"123", "md5":"123", "server_name":"xinlang"}], "authen_token" : "wrong"}'
        -   403 error
    -   create a file successful
        -   curl -s "http://localhost:3000/api/v1/virfiles" -X POST -H 'Content-Type: application/json' -d '{"abs_path":{"user_name":"test00", "path":""}, "file_inf":{"name":"ff2", "frag_num":2, "if_file": true, "file_sha1":"123", "file_md5":"123"}, "frag_arr" : [{"addr":"www/baidu/com", "index":1, "sha1":"123", "md5":"123", "server_name":"xinlang"}, {"addr":"www.google.com", "index":2, "sha1":"123", "md5":"123", "server_name":"xinlang"}], "authen_token" : "dag=="}'
    
    -   create a directory successful
        -   curl -s "http://localhost:3000/api/v1/virfiles" -X POST -H 'Content-Type: application/json' -d '{"abs_path":{"user_name":"test00", "path":""}, "file_inf":{"name":"firstd1", "frag_num":0, "if_file":false}, "authen_token":"sdg=="}'
        -   {"suc":true}

### <a id="showFrag" name="showFrag"></a> show<a id="sec-2-5-3" name="sec-2-5-3"></a>

1.  description

    -   show all the frag of "path"
    -   POST   /api/v1/virfiles/show(.:format)

2.  request and response

    -   request {"abs_path" : {"user_name" : <name>, "path" : <path>}, "authen_token" : <token>}
    -   response for directory {"if_file" : false, "frag_num" : 0}
    -   response for file {"if_file" : true, "frag_num" : 7, "file_sha1" : "123", "file_md5" : "456", "frag_list" : [{"addr" : "abc", "index" : 3, "sha1" : "2", "md5" : "6", "server_name" : "xinlang"}]}
        -   *if_file == true* for file
        -   frag_num is the amount of frags.

3.  e.g.

    -   directory
        -   curl -s "http://localhost:3000/api/v1/virfiles/show" -X POST -H 'Content-Type: application/json' -d '{"abs_path":{"user_name":"test00", "path":"firstd1"}, "authen_token":"1ZOmWA=="}'
        -   {"if_file":false,"frag_num":0}
    -   file
        -   curl -s "http://localhost:3000/api/v1/virfiles/show" -X POST -H 'Content-Type: application/json' -d '{"abs_path":{"user_name":"test00", "path":"first"}, "authen_token":"ZOmWA=="}'
        -   {"if_file":true,"frag_num":2,"file_sha1":"123","file_md5":"123","frag_list":[{"addr":"www.google.com","index":2,"sha1":"123","md5":"123","server_name":"xinlang"},{"addr":"www/baidu/com","index":1,"sha1":"123","md5":"123","server_name":"xinlang"}]}

### <a id="deleteFile" name="deleteFile"></a> destroy<a id="sec-2-5-4" name="sec-2-5-4"></a>

1.  description

    -   delete "path" of "user_name"
    -   DELETE /api/v1/virfiles/delete(.:format)

2.  request and response

    -   request {"abs_path" : {"user_name" : <name>, "path" : <path>}, "authen_token" : <token>}
    -   response {"suc" : true}

3.  e.g.

    -   curl -s "http://localhost:3000/api/v1/virfiles/delete" -X DELETE -H 'Content-Type: application/json' -d '{"abs_path":{"user_name":"test00", "path":"firstd"}, "authen_token":"C1ZOmWA=="}'
    -   {"suc":true}

## <a id="testHello" name="testHello"></a> test hello<a id="sec-2-6" name="sec-2-6"></a>

### description<a id="sec-2-6-1" name="sec-2-6-1"></a>

only for test

### request and response<a id="sec-2-6-2" name="sec-2-6-2"></a>

-   get /api/v1/hello
-   response {"greet": "hello world"}

# Security<a id="sec-3" name="sec-3"></a>

## XSS(Cross-Site Scripting)<a id="sec-3-1" name="sec-3-1"></a>

-   It's the most common hack way.
-   Fortunately, after rails 3, all the stuffs in View are "escape" by default.

## CSRF(Cross-site request forgery)<a id="sec-3-2" name="sec-3-2"></a>

-   All the reading or require operation only use GET method.
-   Security token for POST, DELETE and etc.
    -   add "protect_from_forgery with: :exception" in /app/controllers/application_controller.rb

## SQL injection<a id="sec-3-3" name="sec-3-3"></a>

-   It's one of the most horribe attack.
-   We have to escape all the statement that passes parameters to function which controls SQL.
    -   For *Where* method in *ActiveRecord* , never use string parameters. Because *Hash* and *Array* can deal with this hack automatically.
        -   e.g. *Project.where( { :name => params[:name] } )*
    -   No automatical escape for the method below:
        -   find_by_sql
        -   execute
        -   where with string parameters
        -   group
        -   order

## Mass assignment<a id="sec-3-4" name="sec-3-4"></a>

-   It's a specific security problem caused by the convenient of rails
-   We use *Strong Parameters* to make sure that it's safe enough to *Mass assignment* operation.

## Filter sensitive information<a id="sec-3-5" name="sec-3-5"></a>

-   e.g. for password
    -   *Rails.application.config.filter_parameters += [:password]* in *config/initializers/filter_parameter_logging.rb*
    -   Processing UsersController#create (for 127.0.0.1 at 2009-01-02 11:02:33) [POST]

Parameters: {"user"=>{"name"="susan", "password_confirmation"="[FILTERED]", "password"="[FILTERED]"}, "commit"="Register", "action"="create", "authenticity_token"="9efc03bcc37191d8a6dc3676e2e7890ecdfda0b5", "controller"="users"}