# Week 9-10: Integrating sound with colour detection for real-time interaction

## What I Did

Week 9–10 felt like the moment where everything I had been thinking about—sound, colour instability, multisensory logic—finally had to meet reality. After getting the basic colour detection running in the previous weeks, this was the first time I tried to connect it to the sound mapping I had been developing earlier. Even though the colour readings were still a bit unpredictable, I wanted to see how it would feel when the system actually responded to colour with sound in real time. In other words: this was my first attempt to turn the project into something interactive rather than theoretical.

### Bridging Two Worlds (Visual → Audio)

I started with a very simple bridge between the OpenCV output and the sound files I generated earlier using Suno. Instead of building a complex real-time sound synthesis system, I focused on something achievable:
each colour category would trigger a corresponding audio clip.

It wasn’t elegant, but it allowed me to test whether the relationship between colour and sound felt right when happening live. The strange part is that even this basic version taught me a lot. For example, when the colour reading flickered randomly (which happened often), the sound would also flicker, creating a kind of chaotic audio stutter. It was annoying at first, but then I realised it was actually a meaningful signal—it showed me exactly what “perceptual uncertainty” sounds like when translated too literally.

This made me rethink what “real time” should mean. Maybe the sound shouldn’t react instantly. Maybe it needs to interpret, or smooth, or “hold” the colour instead of copying it.

### First Attempts at Smoothing Sound Responses

Because the raw colour readings were too jittery, I added a simple delay and smoothing mechanism before the sound was allowed to change. I tested different timings—0.3 seconds felt too slow, 0.05 seconds was too fast—until I got something that made the sound feel more like a reaction and less like a technical glitch.

It still wasn’t perfect, but it had the beginning of a “behavioural personality.”
For example:

red would fade in when the system became confident it really was red

green felt more stable but took slightly longer to confirm

yellow fluctuated more than I expected but sounded surprisingly warm

These small behaviours actually reflected what I learned from my survey: colours that participants felt more uncertain about tended to behave more erratically in the system too. It was like the system was unintentionally mirroring human perceptual logic.

![屏幕截图 2025-11-08 221146](https://git.arts.ac.uk/user-attachments/assets/ff82c898-e883-4089-aa27-f329bba8f1c6)

### Experiments With Real Objects (Again, But Now With Sound)

I repeated the fruit tests from Week 7–8, but this time with sound turned on. This made the whole process feel different. Instead of watching numbers change on the screen, I was listening to the system “react.” Interestingly, I could hear the instability much more clearly than I could see it.

For example:

a tomato produced a “red” tone, but every time a reflection hit, it momentarily produced something closer to “orange,” giving a wobbly sound

green apples would alternate between green and yellow tones depending on distance

anything shiny (like packaged snacks) caused colour trembling, which sounded like rapid note switching

These weren’t failures—they were insights. They helped me understand what parts of the visual pipeline needed more filtering before they were allowed to influence sound.

### Understanding Sound as a Stabiliser, Not a Mirror

At some point during Week 10, I had a small breakthrough:
If the sound changes too fast, it amplifies uncertainty instead of stabilising it.

So instead of making the sound mirror the colour detection output directly, I started treating sound more like a confidence indicator. The colour had to “prove itself” before the sound changed. This subtle shift made the system feel less jittery and more supportive.

This idea also matched the conceptual flow I drew in my thesis (colour input → perceptual uncertainty → sound intervention → confidence). Even though I didn’t literally reference that diagram in my notes, it was definitely in the back of my mind when tuning the system’s behaviour.

Test code link：[Test](https://git.arts.ac.uk/24010647/Colour-Soundscape-Advanced-Project/tree/main/demo%20test/MusicPlay_CN_Test01)

## Challenges

The biggest challenge was figuring out how responsive the system should be. Too fast, and the sound became chaotic. Too slow, and the system felt laggy or unhelpful. I also noticed that different colours had different stability needs—green needed more smoothing, while red seemed fine with quicker changes. This meant I couldn’t treat all colours equally, which made the system more complex than I expected.

Another issue was emotional tone. Some Suno sounds worked nicely; others were too musical or too dramatic when triggered repeatedly. I had to adjust volumes, shorten clips, and sometimes remove parts that sounded overwhelming in real time.

## What I’m Thinking Now

After these two weeks, I finally feel like the project is becoming a real interactive system instead of an abstract idea. Seeing (and hearing) the colours respond—even imperfectly—made the whole multisensory concept much clearer. I learned that sound shouldn’t simply translate colour; it should help stabilise it. The sound layer is more like a guide than a mirror.

It also made me realise how important the emotional dimension is. A sound can make users feel confident or confused, calm or rushed. This shifted my thinking toward designing the installation not just as a technical tool, but as an environment with a tone, rhythm, and presence.

## Next Steps

For the next phase, I’m planning to:

redesign certain sound clips so they work better in short loops,

improve the smoothing logic so sound transitions feel more natural,

test interaction under different lighting conditions, and prepare for small user testing sessions.

This will help me move toward a prototype that feels stable, intuitive, and emotionally supportive for CVD users.
