README FOR MODELS
====================
Files Description
--------------------
| Name | Description |
|:----:|:-----------:|
| concerns/ | Shared Mixin Module |
| .keep | keep track of `concerns/` |
| fragfile.rb | maintain `fragfiles` (with address) |
| physfile.rb | connection between `virfiles` and `fragfiles` |
| user.rb | maintain `users` |
| virfile.rb | maintain `virfiles`:: files exposed to **client** |

Explanations
--------------------
* Virfile
	- use `phys_id` to indicate whether it's a directory or file:
		+ `directory`::phys_id == -1
		+ `file`::phys_id >= 0
	- all the `path` means **absolute path**
* Extract fragments
	- use method `Virfile.find_by_path`, return @file
	- `phys_id <= @file.phys_id`
	- use method `Fragfile.find_all` to extract fragments by *phys_id*
	- use method `Physfile.find_id`, return @phys
	- **check:** `@phys.frag_num =? number of fragment`
* Upload
	- use method `Physfile.creat`, return @phys (No need for an empty **directory**)
	- use method `Virfile.creat` to **upload** the file
	- use method `Physfile.modify` to modify the *number* of fragments
	- use method `Fragfile.creat` to **upload** fragments
