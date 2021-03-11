# Def-SFX

Def-sfx expands upon the built-in Defold Sound System and provides support for 3D sound and real-time pan.

- [Def-SFX](#def-sfx)
  - [Installation](#installation)
  - [Basic Usage](#basic-usage)
    - [Register a sound](#register-a-sound)
    - [Playing a sound](#playing-a-sound)
    - [Stopping a sound](#stopping-a-sound)
  - [API](#api)
    - [SFX Source](#sfx-source)
    - [SFX Manager](#sfx-manager)
    - [SFX Module](#sfx-module)
  - [Usage](#usage)

## Installation

You can use the Def-SFX in your own project by adding this project as a [Defold library dependency](http://www.defold.com/manuals/libraries/). Open your game.project file and in the dependencies field under project add:

https://github.com/TheKing009/def-sfx/archive/main.zip

Or point to the ZIP file of a [specific release](https://github.com/TheKing009/def-sfx/releases).

## Basic Usage

Add the ```sfx_manager``` gameobject to a collection.

Subsequently, add the sfx_source.script to the source of the sound and configure it.

### Register a sound

The sources that have a sfx source attached are automatically registered with the sfx manager. The other sources need to be registered manually by messaging SFX Manager with a [```register```](#sfx-manager) message.

### Playing a sound

The sound can then be played by either sending a ```play``` message to SFX Manager or calling the ```play``` function of ```sfx.lua```.Both take a single parameter ```id``` - the ID of the sound to be played.

### Stopping a sound

The sound can be stopped by either sending a ```stop``` message to SFX Manager or calling the ```stop``` function of ```sfx.lua```.Both take a single parameter ```id``` - the ID of the sound to be played.

**For sources using a sound source script, it's game object id is it's id**

## API

### SFX Source

Has no public functions that can be called or messages that can be passed. Instead, it contains several properties that can be congfigured.

|Property |Explanation|
|------|-----------------------------------------|
| Path | The path of the sound component         |
|Sfx Manager|The path of the sfx manager component. Need not be modified if you are using the built-in ```sfx_manager.go```|
|Is 2D|Whether this is a planar sound|
|Pan|Whether this source should use realtime pan|
|Range 2D| The maximum range of the 2D sound|
|Pan Range| The maximum range for realtime pan. Beyond this, the sound is completely panned toward one side|
|Play On Awake|Whether this source should start playing on awake|
| gain | The gain of the sound source            |

### SFX Manager

- ```register``` : ```message```
    Registers a sound source with SFX Manager.

    Parameters :

    Takes a single parameter called ```properties``` that should contain the following fields : 

    |Field |Use|
    |------|-----------------------------------------|
    | id   | The unique id of the sound to be played |
    | path | The path of the sound component         |
    | gain | The gain of the sound source            |

- ```unregister``` : ```message``` Unregisters a sound source from SFX Manager

  Parameters :
  Takes a single parameter ```id``` that is the id of the sound to be unregistered.

- ```play``` : ```message``` Plays a sound

    Parameters:
    Takes a single parameter ```id``` that is the id of the sound to be played.

- ```stop``` : ```message``` Stops a sound

    Parameters :
    Takes a single parameter ```id``` that is the id of the sound to be stopped.

### SFX Module

- ```play``` : ```function``` Plays a sound.
  
    Parameters:
    Takes a single parameter ```id``` that is the id of the sound to be played.

- ```stop``` : ```function``` Stops a sound.
  
    Parameters:
    Takes a single parameter ```id``` that is the id of the sound to be played.

## Usage

```lua
function init(self)
    local properties = 
    {
        id = hash("jump"),
        path = msg.url("#sound"),
        gain = 1
    }

    msg.post("/sfx_manager#script", "register", {properties = properties})
end

function final(self) 
    msg.post("/sfx_manager#script", "register", {id = hash("jump")})
end

function on_input (self, action_id, action)
    if action_id == hash("key_space") then
        msg.post("/sfx_manager#script", "play", {id = hash("jump")})
    end
end
```

> **See the examples for more details.**

Happy Defolding!

---
