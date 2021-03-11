# Def-SFX

Def-sfx expands upon the built-in Defold Sound System and provides support for 3D sound and real-time pan.

## Installation

You can use the Def-SFX in your own project by adding this project as a [Defold library dependency](http://www.defold.com/manuals/libraries/). Open your game.project file and in the dependencies field under project add:

https://github.com/TheKing009/def-sfx/archive/main.zip

Or point to the ZIP file of a [specific release](https://github.com/TheKing009/def-sfx/releases).

## Basic Usage

Add the ```sfx_manager``` gameobject to a collection.

Subsequently, add the sfx_source.script to the source of the sound and configure it.

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

```register``` : ```message```
Registers a sound source with SFX Manager.

Parameters :

Takes a single parameter called ```properties``` that should contain the following fields : 

|Field |Use|
|------|-----------------------------------------|
| id   | The unique id of the sound to be played |
| path | The path of the sound component         |
| gain | The gain of the sound source            |

```unregister``` : ```message``` Unregisters a sound source from SFX Manager

Parameters :
Takes a single parameter ```id``` that is the id of the sound to be unregistered.

```play``` : ```message``` Plays a sound

Parameters:
Takes a single parameter ```id``` that is the id of the sound to be played.

```stop``` : ```message``` Stops a sound

Parameters :
Takes a single parameter ```id``` that is the id of the sound to be stopped.

Happy Defolding!

---
