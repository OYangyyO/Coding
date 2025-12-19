# Week 11-13: Prototype development and testing with users

## Prototype Form Exploration

Before these three weeks truly transitioned into user testing, a significant amount of time went into shaping the physical form of the interactive device. I began with rough sketches exploring three possible directions:

Concept 1: A dome-like arch offering a stable, enclosed lighting environment.

Concept 2: A horizontal overhead bar offering flexibility but visually rigid.

Concept 3: A lamp-like separate camera–light structure that lacked integration.

After sketching these ideas, I discussed them with my tutor. He pointed out that Concepts 1 and 2 actually complemented each other. His suggestion was to merge the two: keep the arch’s emotional softness and spatial clarity, while integrating the functional structure of the overhead bar. This hybrid approach would allow the device to feel like a complete product while preserving a free, natural interaction space.

![Sketch](https://git.arts.ac.uk/user-attachments/assets/1c259161-f7bc-432a-8826-03fac5de9a30)

## Tutor Consultation Summary

The tutor meeting influenced more than just the form development. He also highlighted several important points:

* Comparison group: He recommended testing with both CVD and non-CVD participants to observe perceptual differences.

* Depth over numbers: He emphasized that the value of user testing lies in careful observation—gestures, hesitations, micro-reactions—rather than the quantity of participants.

* Alignment with thesis: He encouraged me to let my thesis arguments on multisensory trust guide each design decision.

This guidance shaped how I structured the subsequent user tests.

## 3D Modelling & Prototyping

After deciding on the merged arch–bar concept, I moved into Blender to model proportions, lighting angles, and camera placement. I printed a small 3D test model to evaluate how users’ hands would move, how food would sit under the arch, and how shadows behaved. Once satisfied, I built the full-scale prototype with a soft LED strip embedded along the arc and a top-mounted camera for consistent detection.

![屏幕截图 2025-11-24 201208](https://git.arts.ac.uk/user-attachments/assets/b2f69ac2-7134-4192-801e-d3d29714ac8a)

## Design Thinking
I kept noticing that whenever I moved objects around my desk, the smallest shadows or reflections would immediately change the colour output. That kind of instability might be tolerable in my own experiments, but it wouldn’t make sense to users, especially those who already struggle with colour discrimination. So I decided the prototype needed its own “micro-environment” where everything—from the lighting to the distance to the background—could be controlled. That’s why I built this arched structure: it creates a small, clearly defined space, almost like a tasting station or a miniature photography setup, but still friendly enough to fit the context of food selection. The soft LED strip ensures even, neutral lighting; the pale background reduces distractions; and the camera angle is fixed so every user is “seen” the same way by the system. In hindsight, it looks almost like a tiny scientific instrument combined with a dining ritual, which actually captures the atmosphere I wanted.

![57cb31ec0f54ae97690034c489c9bce7](https://git.arts.ac.uk/user-attachments/assets/6cac3053-e98b-4f92-a206-4e6af5b6f32b)

![4515c59bd7ae4835657ade634a86fa2c](https://git.arts.ac.uk/user-attachments/assets/bb80cd8e-d4c4-439c-bfb3-f832f643c84c)


When participants came in, the first thing they noticed was the arch. Most of them instinctively placed the fruit right under the centre without me even explaining—almost like the shape told them what to do. I laid out the food on a plate to keep the context close to a real-life situation, not a lab test. The idea was that this system should feel like something you could imagine using while choosing food, not something only researchers understand.

## User Testing
After the meeting with my supervisor, I tested the prototype with five participants: three with different types of CVD and two with typical colour vision. The structure of the test had two stages: first making choices only with vision, and then repeating the same decisions with the sound feedback active. But in reality, the most revealing part wasn’t their answers—it was how they behaved physically under the arch.

### Participant A — CVD (red-green)

He sat down, looked at the arch, and said, “It feels like a little checkpoint,” which was funny because that was exactly the vibe I unconsciously built into it. When he started the vision-only task, he kept rotating the apples very slowly under the arch light, as if the lighting would eventually reveal a secret. Under the sound condition, I watched his shoulders drop a little. He kept switching between the two apples, waiting patiently for each sound to settle. He finally said:

“I don’t really know the difference between these two colours, but the sound feels steadier for this one. So I trust that.”

This “steadiness” was exactly what I hoped to achieve with the smoothing logic. Watching him interact with the arch made me realise the physical structure was doing as much emotional work as the sound—because it made the environment predictable.

![image](https://git.arts.ac.uk/user-attachments/assets/916e1954-5de0-46c2-bebd-f37f72fb8551)

### Participant B — CVD (deuteranomaly)

She was more analytical. The moment she put the bananas under the arch, she commented on the lighting:
“Ah, this helps. It’s not as confusing as supermarket lights.”

During the sound stage, she held the fruit absolutely still, almost too still, waiting for the tone to fade in completely before judging. She described the sound as:

“Something that completes the decision for me… like a confirmation.”

She pointed out that the arch made her feel more focused, because nothing in the background competed for attention. She said she would’ve been more confused in a normal environment.

![63c6b2bf79313facaac98a6c601ba26c](https://git.arts.ac.uk/user-attachments/assets/7c49ff7b-c2f7-42a4-9799-251b9ce75ce9)

### Participant C — CVD (mild colour distortion)

This participant interacted with the system almost playfully. He moved objects to the very edges of the arch and then brought them back to the centre, observing how both the light and sound reacted.
“This thing is actually teaching me how unstable colour is,” he said, laughing.
He wasn’t relying on the sound to choose fruit, but he used it to understand what the system was “seeing.” The arch made him treat the task almost like exploring a small instrument rather than solving a problem.

### Participant D — Typical vision

He didn’t struggle with colour, but something about the arch made him slow down. He touched the light strip with his fingertips and said, “This feels very controlled… like I’m doing a careful test.”
When the sound came on, he rotated an apple and tried to chase the tiniest sound wobble caused by reflections.
“There’s something meditative about this,” he said.
This was the first time I realised that typical-vision users also benefited—not from clarifying colour, but from paying attention differently.

### Participant E — Typical vision

She approached the setup almost too casually at first, but the arch made her lean forward, as if entering a smaller, quieter space. Under the sound condition, she held the fruit longer than expected and said:

“It feels like the system wants me to listen. I don’t usually choose fruit this slowly.”

The arch, combined with the sound, created a kind of “pause”—a moment where she reevaluated colour as more than something that is simply seen.

## Overall Reflections (My Summary)

Over these two weeks, the combination of the arch structure and the sound output created a surprisingly intimate, focused experience. The physical design wasn’t just a technical necessity—it shaped how participants behaved. The uniform light removed visual noise, the stable background removed context confusion, and the gentle curve of the arch framed the food the way a lens frames a photograph. People naturally slowed down, became more intentional, and paid attention with both their eyes and their ears.

The most important insight was that the system doesn’t need to “fix” colour for CVD users—it just needs to make the experience of uncertainty less stressful. The arch supported this by creating a stable visual environment; the sound supported it by creating a stable emotional environment. Together, they turned a moment of doubt into a moment of exploration.

If anything, this stage taught me that multisensory design isn’t only about adding senses—it’s about adding clarity, ritual, and sometimes even comfort.
