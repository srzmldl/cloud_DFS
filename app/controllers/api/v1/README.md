<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#sec-1">1. Files</a></li>
<li><a href="#sec-2">2. API description</a>
<ul>
<li><a href="#sec-2-1">2.1. directory</a></li>
<li><a href="#sec-2-2">2.2. tips</a></li>
<li><a href="#sec-2-3">2.3. users<sub>controller</sub></a>
<ul>
<li><a href="#sec-2-3-1">2.3.1. show</a></li>
<li><a href="#sec-2-3-2">2.3.2. create(register)</a></li>
</ul>
</li>
<li><a href="#sec-2-4">2.4. sessions<sub>controller</sub></a>
<ul>
<li><a href="#sec-2-4-1">2.4.1. create(login)</a></li>
</ul>
</li>
<li><a href="#sec-2-5">2.5. virfiles<sub>controller</sub></a>
<ul>
<li><a href="#sec-2-5-1">2.5.1. index(list all the files in the directory)</a></li>
<li><a href="#sec-2-5-2">2.5.2. create</a></li>
<li><a href="#sec-2-5-3">2.5.3. show</a></li>
<li><a href="#sec-2-5-4">2.5.4. destroy</a></li>
</ul>
</li>
<li><a href="#sec-2-6">2.6. test hello</a></li>
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
<td class="left">base<sub>controller</sub>.rb</td>
<td class="left">base controller</td>
</tr>


<tr>
<td class="left">sessions<sub>controller</sub>.rb</td>
<td class="left">log in</td>
</tr>


<tr>
<td class="left">users<sub>controller</sub>.rb</td>
<td class="left">user create, show</td>
</tr>


<tr>
<td class="left">virfiles<sub>controller</sub>.rb</td>
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
-   Please change all the "<http://localhost:3000>" into "<http://222.195.92.170:3000>" (It could be changed frequently)
-   path == "" for root directory for every user
-   Every method to operate the virfile have to be verified at the very beggining. We have to receive {verify<sub>info</sub>, :user<sub>name</sub>, :authen<sub>token</sub>}. 403 error for wrong authen<sub>token</sub>

## users<sub>controller</sub><a id="sec-2-3" name="sec-2-3"></a>

### <a id="userShow" name="userShow"></a> show<a id="sec-2-3-1" name="sec-2-3-1"></a>

-   show the profile by token and user<sub>name</sub> after verify.
-   POST   /api/v1/users/profile(.:format)
-   return {@user}.
    -   attribute of @user *:name, :register<sub>date</sub>*
-   400 for error name & 403 for error token
-   400 or 403 e.g.
    -   curl -s "<http://localhost:3000/api/v1/users/profile>" -X POST -H 'Content-Type: application/json' -d '{"show<sub>user</sub>":{"name":"test00", "authen<sub>token</sub>":"50z7tPyBiKomBRd5i5iTdMG4QKZlZ3cT0qgVQWRoq49bwj52nW4dvhd0zJ4xbVT587Qx6mGOAUiBbzA8RNh67w="}}'
    -   403 error
-   successful e.g.
    -   curl -s "<http://localhost:3000/api/v1/users/profile>" -X POST -H 'Content-Type: application/json' -d '{"show<sub>user</sub>":{"name":"test00", "authen<sub>token</sub>":"50z7tPyBiKomBRd5i5iTdMG4QKZlZ3cT0qgVQWRoq49bwj52nW4dvhd0zJ4xbVT587Qx6mGOAUiBbzA8RNh67w=="}}'
    -   {"user":{"name":"test00","register<sub>date</sub>":"2015-07-20"}}

### <a id="createUser" name="createUser"></a> create(register)<a id="sec-2-3-2" name="sec-2-3-2"></a>

-   register a new user
-   POST   /api/v1/users(.:format)
-   receive {:name, :password};
-   feedback {@user, @state}
    -   Meaning of state:
        -   -1  |name| < 3
        -   -2  |password| < 6
        -   -3 user already exist.
        -   0 no error
    -   attribute of @user: as same as those in show

-   short password e.g.
    -   curl -s "<http://localhost:3000/api/v1/users>" -X POST -H 'Content-Type: application/json' -d '{"register<sub>user</sub>":{"name":"test0", "password":"12"}}'
    -   {"state":-2}
-   short user name e.g.
    -   curl -s "<http://localhost:3000/api/v1/users>" -X POST -H 'Content-Type: application/json' -d '{"register<sub>user</sub>":{"name":"t", "password":"12345678"}}'
    -   {"state":-1}
-   successful e.g. 
    -   curl -s "<http://localhost:3000/api/v1/users>" -X POST -H 'Content-Type: application/json' -d '{"register<sub>user</sub>":{"name":"test00", "password":"12345678"}}'
    -   {"state":0,"user":{"name":"test00","register<sub>date</sub>":"2015-07-20","authen<sub>token</sub>":"50z7tPyBiKomBRd5i5iTdMG4QKZlZ3cT0qgVQWRoq49bwj52nW4dvhd0zJ4xbVT587Qx6mGOAUiBbzA8RNh67w=="}}
-   duplicate name e.g.
    -   curl -s "<http://localhost:3000/api/v1/users>" -X POST -H 'Content-Type: application/json' -d '{"register<sub>user</sub>":{"name":"test00", "password":"12345678"}}'
    -   {"state":-3}

## sessions<sub>controller</sub><a id="sec-2-4" name="sec-2-4"></a>

### <a id="login" name="login"></a> create(login)<a id="sec-2-4-1" name="sec-2-4-1"></a>

-   login and get user information & token
-   POST   /api/v1/sessions(.:format)
-   Receive {@user, :name, password}
-   feedback {login<sub>suc</sub>, @user}
    -   *login<sub>suc</sub> = true* if success.
    -   *@user = nil* when *login<sub>suc</sub> == false*
    -   attribute of @user :name, :register<sub>date</sub>, :authen<sub>token</sub>
-   401 error if login fail
-   successful e.g.   
    -   curl -s "<http://localhost:3000/api/v1/sessions>" -X POST -H 'Content-Type: application/json' -d '{"user":{"name":"test00", "password":"12345678"}}'
    -   {"login<sub>suc</sub>":true,"user":{"name":"test00","register<sub>date</sub>":"2015-07-20","authen<sub>token</sub>":"50z7tPyBiKomBRd5i5iTdMG4QKZlZ3cT0qgVQWRoq49bwj52nW4dvhd0zJ4xbVT587Qx6mGOAUiBbzA8RNh67w=="}}
-   fail e.g.
    -   curl -s "<http://localhost:3000/api/v1/sessions>" -X POST -H 'Content-Type: application/json' -d '{"user":{"name":"test00", "password":"123456789"}}'
    -   401 error

## virfiles<sub>controller</sub><a id="sec-2-5" name="sec-2-5"></a>

### <a id="fileIndex" name="fileIndex"></a> index(list all the files in the directory)<a id="sec-2-5-1" name="sec-2-5-1"></a>

-   list files and directory in :path of :user<sub>name</sub>
-   POST   /api/v1/virfiles/index(.:format)
-   receive {abs<sub>path</sub>, verify<sub>info</sub>}
    -   attributes :user<sub>name</sub>, :path
    -   learn more about verify<sub>info</sub> in tips
-   feedback {list}
    -   list is an array, its element is virfiles(:id, :name, :if<sub>file</sub>)
    -   *if<sub>file</sub> == true* means that it's a file, a directory otherwise.
-   e.g.
    -   curl -s "<http://localhost:3000/api/v1/virfiles/index>" -X POST -H 'Content-Type: application/json' -d '{"abs<sub>path</sub>":{"user<sub>name</sub>":"test00", "path":""}, "authen<sub>token</sub>":"50z7tPyBiKomBRd5i5iTdMG4QKZlZ3cT0qgVQWRoq49bwj52nW4dvhd0zJ4xbVT587Qx6mGOAUiBbzA8RNh67w=="}'
    -   {"list":[{"name":"first","if<sub>file</sub>":true},{"name":"firstd","if<sub>file</sub>":true},{"name":"firstd1","if<sub>file</sub>":false}]}

-   e.g.
    -   curl -s "<http://localhost:3000/api/v1/virfiles/index>" -X POST -H 'Content-Type: application/json' -d '{"abs<sub>path</sub>":{"user<sub>name</sub>":"test00", "path":"firstd1/"}, "authen<sub>token</sub>":"Je6aWTPs/PoLRJ8yUm1ve1QKQ5d8E0KACdALlRkt7PZ6WX7ZKqUDIUb/F/ZJPqeYFpPO3dMMSIDuO6/C1ZOmWA=="}'
    -   {"list":[{"name":"secondfile","if<sub>file</sub>":true}]}

### <a id="listFile" name="listFile"></a> create<a id="sec-2-5-2" name="sec-2-5-2"></a>

-   POST   /api/v1/virfiles(.:format)
-   receive {abs<sub>path</sub>, file<sub>inf</sub>, frag<sub>arr</sub>, verify<sub>info</sub>}
    -   file<sub>inf</sub> includes name & frag<sub>num</sub>
    -   abs<sub>path</sub> includes user<sub>name</sub> & path & if<sub>file</sub>. We will create a new file or directory under "path" or "user<sub>name</sub>"
        -   if<sub>file</sub> == 1 means it's a file, otherwise a directory
-   feedback {state}
-   fail e.g.
    -   curl -s "<http://localhost:3000/api/v1/virfiles>" -X POST -H 'Content-Type: application/json' -d '{"abs<sub>path</sub>":{"user<sub>name</sub>":"test00", "path":""}, "file<sub>inf</sub>":{"name":"ff2", "frag<sub>num</sub>":2, "if<sub>file</sub>": true, "file<sub>sha1</sub>":"123", "file<sub>md5</sub>":"123"}, "frag<sub>arr</sub>" : [{"addr":"www/baidu/com", "index":1, "sha1":"123", "md5":"123", "server<sub>name</sub>":"xinlang"}, {"addr":"www.google.com", "index":2, "sha1":"123", "md5":"123", "server<sub>name</sub>":"xinlang"}], "authen<sub>token</sub>" : "wrong"}'
    -   403 error
-   create a file successful
    -   curl -s "<http://localhost:3000/api/v1/virfiles>" -X POST -H 'Content-Type: application/json' -d '{"abs<sub>path</sub>":{"user<sub>name</sub>":"test00", "path":""}, "file<sub>inf</sub>":{"name":"ff2", "frag<sub>num</sub>":2, "if<sub>file</sub>": true, "file<sub>sha1</sub>":"123", "file<sub>md5</sub>":"123"}, "frag<sub>arr</sub>" : [{"addr":"www/baidu/com", "index":1, "sha1":"123", "md5":"123", "server<sub>name</sub>":"xinlang"}, {"addr":"www.google.com", "index":2, "sha1":"123", "md5":"123", "server<sub>name</sub>":"xinlang"}], "authen<sub>token</sub>" : "Q0ksIastifLXxNU4aAzh/o09RWzy1lVESvcTHYdLaIfWywUW5PtbeikEoPVO2+z5GzJpCUSxqudEfCtTulRWYg=="}'

-   create a directory successful
    -   curl -s "<http://localhost:3000/api/v1/virfiles>" -X POST -H 'Content-Type: application/json' -d '{"abs<sub>path</sub>":{"user<sub>name</sub>":"test00", "path":""}, "file<sub>inf</sub>":{"name":"firstd1", "frag<sub>num</sub>":0, "if<sub>file</sub>":false}, "authen<sub>token</sub>":"50z7tPyBiKomBRd5i5iTdMG4QKZlZ3cT0qgVQWRoq49bwj52nW4dvhd0zJ4xbVT587Qx6mGOAUiBbzA8RNh67w=="}'
    -   {"suc":true}

### <a id="showFrag" name="showFrag"></a> show<a id="sec-2-5-3" name="sec-2-5-3"></a>

-   show all the frag of :path
-   POST   /api/v1/virfiles/show(.:format)
-   receive {abs<sub>path</sub>}
    -   attributes  :user<sub>name</sub>, :path
-   feedback {if<sub>file</sub>, frag<sub>num</sub>, frag<sub>list</sub>}
    -   *if<sub>file</sub> == true* for file
    -   frag<sub>num</sub> is the number of frag.
    -   frag<sub>list</sub> is the list of {addr, index}
-   e.g.
    -   curl -s "<http://localhost:3000/api/v1/virfiles/show>" -X POST -H 'Content-Type: application/json' -d '{"abs<sub>path</sub>":{"user<sub>name</sub>":"test00", "path":"firstd1"}, "authen<sub>token</sub>":"Je6aWTPs/PoLRJ8yUm1ve1QKQ5d8E0KACdALlRkt7PZ6WX7ZKqUDIUb/F/ZJPqeYFpPO3dMMSIDuO6/C1ZOmWA=="}'
    -   {"if<sub>file</sub>":false,"frag<sub>num</sub>":0}
-   e.g.
    -   curl -s "<http://localhost:3000/api/v1/virfiles/show>" -X POST -H 'Content-Type: application/json' -d '{"abs<sub>path</sub>":{"user<sub>name</sub>":"test00", "path":"first"}, "authen<sub>token</sub>":"Je6aWTPs/PoLRJ8yUm1ve1QKQ5d8E0KACdALlRkt7PZ6WX7ZKqUDIUb/F/ZJPqeYFpPO3dMMSIDuO6/C1ZOmWA=="}'
    -   {"if<sub>file</sub>":true,"frag<sub>num</sub>":2,"file<sub>sha1</sub>":"123","file<sub>md5</sub>":"123","frag<sub>list</sub>":[{"addr":"www.google.com","index":2,"sha1":"123","md5":"123","server<sub>name</sub>":"xinlang"},{"addr":"www/baidu/com","index":1,"sha1":"123","md5":"123","server<sub>name</sub>":"xinlang"}]}

### <a id="deleteFile" name="deleteFile"></a> destroy<a id="sec-2-5-4" name="sec-2-5-4"></a>

-   delete :path of :user<sub>name</sub>
-   DELETE /api/v1/virfiles/delete(.:format)
-   receive {abs<sub>path</sub>}
    -   attribute :user<sub>name</sub>, :path
-   feedback {suc}
-   e.g.
    -   curl -s "<http://localhost:3000/api/v1/virfiles/delete>" -X DELETE -H 'Content-Type: application/json' -d '{"abs<sub>path</sub>":{"user<sub>name</sub>":"test00", "path":"firstd"}, "authen<sub>token</sub>":"Je6aWTPs/PoLRJ8yUm1ve1QKQ5d8E0KACdALlRkt7PZ6WX7ZKqUDIUb/F/ZJPqeYFpPO3dMMSIDuO6/C1ZOmWA=="}'
    -   {"suc":true}

## <a id="testHello" name="testHello"></a> test hello<a id="sec-2-6" name="sec-2-6"></a>

# Security<a id="sec-3" name="sec-3"></a>

## XSS(Cross-Site Scripting)<a id="sec-3-1" name="sec-3-1"></a>

-   It's the most common hack way.
-   Fortunately, after rails 3, all the stuffs in View are "escape" by default.

## CSRF(Cross-site request forgery)<a id="sec-3-2" name="sec-3-2"></a>

-   All the reading or require operation only use GET method.
-   Security token for POST, DELETE and etc.
    -   add "protect<sub>from</sub><sub>forgery</sub> with: :exception" in app/controllers/application<sub>controller</sub>.rb

## SQL injection<a id="sec-3-3" name="sec-3-3"></a>

-   It's one of the most horribe attack.
-   We have to escape all the statement that passes parameters to function which controls SQL.
    -   For *Where* method in *ActiveRecord* , never use string parameters. Because *Hash* and *Array* can deal with this hack automatically.
        -   e.g. *Project.where( { :name => params[:name] } )*
    -   No automatical escape for the method below:
        -   find<sub>by</sub><sub>sql</sub>
        -   execute
        -   where with string parameters
        -   group
        -   order

## Mass assignment<a id="sec-3-4" name="sec-3-4"></a>

-   It's a specific security problem caused by the convenient of rails
-   We use *Strong Parameters* to make sure that it's safe enough to *Mass assignment* operation.

## Filter sensitive information<a id="sec-3-5" name="sec-3-5"></a>

-   e.g. for password
    -   *Rails.application.config.filter<sub>parameters</sub> += [:password]* in *config/initializers/filter<sub>parameter</sub><sub>logging</sub>.rb*
    -   Processing UsersController#create (for 127.0.0.1 at 2009-01-02 11:02:33) [POST]

Parameters: {"user"=>{"name"=>"susan", "password<sub>confirmation</sub>"=>"[FILTERED]", "password"=>"[FILTERED]"}, "commit"=>"Register", "action"=>"create", "authenticity<sub>token</sub>"=>"9efc03bcc37191d8a6dc3676e2e7890ecdfda0b5", "controller"=>"users"}