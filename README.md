# Location-aware task management

Implement some simple web services (with, someday, a UI) for location-based task management.

# Projects

Projects act as a container for tasks. They mark out an area (via `north`, `south`, `east`, and `west`) where work needs to be done.

The projects api is some straightforward CRUD. Until we can get some docs written, see `spec/requests/projects_spec.rb` for sample usage.

# Tasks

Tasks are individual work items within a project. They either have a `lat` and `lon` value (which means they happen at that point) or no spatial location (which means their use is self-evident)

The tasks api is, again, straightforrward CRUD. It is nested as a member api of projects. See `spec/requests/tasks_spec.rb` for sample usage.

# Review highlights

The `Project` and `Task` models make use of as much of the ActiveRecord API as I could rasonably justify.

* `#to_param` override to get permalinks out of path/url helpers
* Custom validation methods
* Scopes (both via the `scope` macro and class methods)
* Declaring inversions of associations to avoid extra DB lookups when following from an association back to the parent/original

The controllers are boring, dumb, nearly mechanical. Devoid of anything resembling business logic beyond shuttling input to models and back. Exactly as they should be.

Code coverage is somewhere north of 90%. The few bits of more complicated code see multiple avenues to testing beyond simply enough to make the lines green.

Total time spent so far is about four hours.
