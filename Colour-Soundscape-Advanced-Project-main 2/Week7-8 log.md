# Week7-8 Colour detection system setup and testing with OpenCV

## What I Did

These two weeks were the first time the project really started to feel “physical.” After spending what felt like ages thinking about sound, metaphors, and multisensory logic, I finally moved on to building the actual colour detection system. I decided to do the first version with OpenCV, just to get a sense of how stable or unstable colour can be when captured through a camera.

Setting everything up was slightly messier than I expected—lighting changes, camera angles, and even reflections made the colours shift way more than I thought they would. But I guess that was also the point: if even a camera sees colour inconsistently, it makes sense why CVD users feel uncertain. So Week 7–8 became a lot of calibration, testing, adjusting, and basically trying to understand what “real-time colour” even means in practice.

### Starting the Camera Pipeline

I started with a very simple OpenCV script that just captured frames from the USB camera and analysed the raw RGB values. My goal was literally just to see what colour the camera “thought” it was seeing. So I took the average RGB value of the main region and tried to classify it into one of my basic colour categories.

It sounded straightforward, but it didn’t behave the way I expected. The same object could look completely different depending on where I placed it, how shiny it was, or even how much light was bouncing off my desk. Sometimes a red apple looked almost orange, and green objects would suddenly shift towards yellow without me even moving them. It felt a bit chaotic, but in a way that helped me understand the instability CVD users face in actual daily life—if the camera itself struggles with colour on a technical level, it’s no wonder people struggle perceptually.

Sounds easy. It wasn’t. Objects with multiple colours confused the detection, shadows made the hue value jump by 20° or more, and the same apple looked like a different fruit depending on where I placed it under the lamp. But in a strange way, all these struggles helped me see why multisensory support matters—my camera was acting like a symbolic “CVD vision,” unreliable and easily affected by tiny environmental factors.

![cbcf122577d753cc7b2fa0b12db83d64](https://git.arts.ac.uk/user-attachments/assets/8f32d0b3-ecf1-4fe1-ad76-db204ea29ac9)

### Refining the Detection Logic

Once I realised how unstable raw hue values were, I started smoothing the results. I introduced averaging across frames so the system wouldn’t panic every time a reflection changed slightly. I also added small thresholds around the hue so that the colour wouldn’t flip between categories instantly.

During this time, I kept thinking back to the flow model from my thesis—the one that goes from colour input → perceptual uncertainty → sound intervention → confidence. Even though I didn’t copy that model directly into this log, it was basically in my head the whole time. When the colour values flickered on my screen, it felt exactly like the “uncertainty” stage in the diagram. And stabilising the numerical output felt like taking the first step toward giving the sound system something more trustworthy to work with.

![image](https://git.arts.ac.uk/user-attachments/assets/da7c5d05-f63b-48f0-a366-dfa39be884dd)

### Early Testing With Real Objects

After getting the detection running, I tried testing it with the actual foods I used in my survey: apples, tomatoes, lemons, etc. The results were… mixed.

Red apples became orange under warm lights.

Green apples sometimes shifted toward yellow.

Tomatoes changed hue depending on their surface reflections.

It made me realise two important things:

Real-world colour is way messier than survey images.

My system needs to clean up the chaos before sound even enters the picture.

This pushed me to treat the detection stage as its own design problem rather than just a technical step.

![屏幕截图 2025-11-04 233411](https://git.arts.ac.uk/user-attachments/assets/24ae5262-6467-40c8-a055-47d2b1846422)

Test code link：[test1](https://git.arts.ac.uk/24010647/Colour-Soundscape-Advanced-Project/tree/main/demo%20test/GetCamera_CN_Test01)

[test2](https://git.arts.ac.uk/24010647/Colour-Soundscape-Advanced-Project/tree/main/demo%20test/GetCameraOpenCV_CN_Test02)

## Connecting It Back to the User Experience

What surprised me most during these two weeks was how the technical challenges mirrored the perceptual problems CVD users talked about in the survey. When the hue flickered, the system “hesitated.” When shadows fell, it became unsure. When two colours were too close, the output became ambiguous.

That’s when I finally understood something I had only written abstractly in my thesis:
colour itself is unstable, and uncertainty is a natural part of perception—not just a “symptom” of CVD.

This made me even more convinced that the sound layer isn’t just decorative—it’s a stabilisation mechanism. But before sound can stabilise anything, the visual input has to be tamed. Week 7–8 was all about figuring out how to do that.

## Challenges

The biggest challenge was dealing with inconsistent colour readings. A tiny move of the camera changed the hue so much that I started to question whether “real-time colour detection” is even a stable concept. I also struggled with lighting—my room light, daylight, and the lamp next to my desk all produced completely different results.

Another challenge was separating “usable colour data” from noise. The system needed to ignore reflections and shadows without losing important details. I had moments when I genuinely felt I was chasing something impossible, but at the same time, these challenges made the system feel more grounded and real.

## What I’m Thinking Now

After these two weeks, I feel like I finally understand what the colour detection part of my system needs to do. It’s not about being perfect—it’s about being stable enough so that the sound mapping has something consistent to work with.

I also started seeing the colour detection stage as the “first layer” of multisensory design. If this layer is shaky, the whole experience becomes shaky. But if I can make the system calm down visually, then the sound can take over and do what it’s supposed to do: guide, reassure, and support the user’s confidence.

## Next Steps

For the next stage, I’m planning to:

refine the RGB thresholds for each colour category,

test under different lighting conditions,

simplify the output so the system doesn’t overreact to tiny hue variations,

and finally connect the stabilised colour output to my sound mapping logic.

This will be the bridge between the visual system I built in Week 7–8 and the auditory system I shaped in Week 5–6.
