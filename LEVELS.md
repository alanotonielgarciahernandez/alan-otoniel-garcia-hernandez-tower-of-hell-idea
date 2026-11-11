# Section rules

A round stacks six sections chosen at random from the twelve models in `ServerStorage`. The same section can appear twice. Each model is placed on the world origin and turned to either 112.5° or -67.5°, so the next floor always faces the opposite way. The bottom of its `Start` pad is set on the top of the previous `End` pad. The first floor's pivot is placed at Y `23.5`.

Build every section for that placement. A floor has to be enterable from any other floor's exit, with the default character.

## The seam

`Tower` measures these parts when it stacks the round. Keep them as they are on `LevelTemplate`.

- Keep one part named `Start` and one part named `End`.
- `Start` stays at local `(0, -7.5, 45)`, size `10 × 0.5 × 20`.
- `End` stays at local X `0` and local Z `-45`, with that same size. On a normal floor its local Y is `7.5`.
- A taller floor may raise `End` on Y only. `HyruleTowers` does this, with `End` at local Y `22`. Leave its X and Z where they are. The half turn lines the next `Start` up with an exit that sits on the opposite side of the pivot, the same distance out.
- The player arrives on top of `Start`, a half-stud step above the previous exit, and leaves on top of `End`, where the next `Start` is the next half-stud step. Leave the top of both pads flat, solid, and clear for the whole pad.
- Keep `Walls` → `TextWall` → `SurfaceGui`, with the `LevelName` and `Author` labels. The round writes the section name and author there.

## The shell

The lobby occupies about X `-54` to `51`, Z `-58` to `58`, up to Y `18`. The first floor is planted at pivot Y `23.5`, so its lower parts already pass through the lobby's height. After either allowed turn, a part outside the shell can land in the lobby or in the neighboring floor.

- Keep solid parts inside the template shell: 102 studs wide, centered on the pivot (±51 in X), and in Z from `51` on the entrance side to about `-58` on the exit side.
- Keep solid parts between the bottom face of `Start` and the top face of `End`. A part above `End` is buried in the next entrance. A part below `Start` sticks into the floor just left.
- Anchor every solid part.
- Leave WalkSpeed, jump height, and gravity alone. The next section is built for the default character.

## The climb

- Give the floor one route from the top of `Start` to the top of `End`.
- Keep rises between standing surfaces at 6 studs or under. The default jump clears about 7.2, and 6 still lands for both body types.
- Keep open gaps around 8 studs. A running jump at speed 16 can clear about 11, and that is the hard end of the range.
- Keep passages at least 4 studs wide and about 6 studs tall.
- Keep parts tagged `Kill` off `Start`, off `End`, and off the only line through the floor.
- Leave the ceiling high over both pads so the player can stand up after the step.
