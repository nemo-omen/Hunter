# SimpleState State Machine
A simple state machine for [Godot](https://godotengine.org) 4.0.

## Installing
One of two ways.
If you have any issues or questions **not** specific to this addon, check out the [tutorial on the Godot docs.](https://docs.godotengine.org/en/latest/tutorials/plugins/editor/installing_plugins.html) 

### AssetLib
You can just pop over to the `AssetLib` tab in the Godot 4 editor,
it should be there somewhere. If it's been a while, you may have to search for it.
Try "SimpleState", and it should come up.

It should automatically only include the `addons/` directory
(which is where the actual addon and everything important is).
Just let it install everything, enable the plugin and enjoy!

PS. You can also find it on the [website](http://godotengine.org/asset-library/asset/1578).

### Manual
If you just want to make life harder for yourself, 
you can download this repository as a zip (bleeding edge, may be unstable), 
or you can go to the [latest release](https://gitlab.com/addons-by-aura/simple-state/-/releases) and download the source code zip from there (stable).

Once you have your zip, open Godot 4, navigate to the `AssetLib` tab, and click the `Import` button. From there, find your zip, select it, and click `Open`.
From here, it's essentially the same as using the AssetLib.

If, for some reason, you *really* don't want to even open the `AssetLib`, you can extract the zip elsewhere and manually move the addon into your project.

## Usage
The addon provides a few new classes:
- `State`, the base class everything else inherits from.
- `RandomState`, which chooses which substate to activate randomly.
- `AnimationState`, which plays the animation with the state's `name`.
- `SequenceState`, which activates its substates one after the other, in order.

If a state doesn't have a `State` parent, it automatically acts as a root.

Check out the in-editor help pages for details about all the ins and outs.
For now, let's talk about the difference between this addon and others like it.

### For users of other "state machine" addons
Every other addon for Godot that implements a state machine of some form
(I think I've tried them all) either uses `GraphEdit` to make an interactive state chart, or it uses nodes like this one does and lets you do whatever willy-nilly.

The state-chart approach often looked nice, but it was hard to actually get it to do what you want. I never really knew what was going on. On the other hand, the node approach was easy, but it was **very** prone to spaghetti-code-ness, as you could change from any state *to* any other state, which meant that the hierarchy didn't really matter all that much. And I still never really knew what was going on! If a state was activating and you didn't know why, good luck finding out!

So, my approach mainly addresses the way state changes work. Basically, the parent has **all** the authority over its children. The best example of this is in the state machine for the player for the game I'm currently working on (the reason I made this addon):

![](https://gitlab.com/addons-by-aura/simple-state/-/raw/master/docs/images/player_state_machine.png)

- In "Input", I check for input from the player. If there is any, it activates "Movement". If not, "Idle". 
- "Movement" also checks for input, but different than "Input". It checks for the sprint key being pressed. If it is, it activates "gallop". Otherwise, it does "trot".

It would have been easy to have "Input" start "trot" or "gallop" directly, but then what would be the point of "Movement"? Why not just have them be direct children of "Input"?

You would have the nodes already in a hierarical format, throwing that out the window and pretending it's a flat hierarchy. And then, what you have is what's called a Mess™️.

Make the parents matter!

### `choose_new_substate_requested`
If a state has decided it's done, it can emit the `choose_new_substate_requested` signal, and the parent can choose a new one, start the same one again, or ignore it altogether.

## Credits
All the code was written by me (@auratheenby), but the ideas for some of the specific features (mainly the timers, and the looping in `AnimationState` and `SequenceState`) came from [this addon](https://gitlab.com/atn_games/xsm2-g4), though I simplified their implementation.

I got the icons for the classes from these assets of [Kenney's](kenney.nl):
[1](https://kenney.nl/assets/board-game-icons)
[2](https://kenney.nl/assets/game-icons)