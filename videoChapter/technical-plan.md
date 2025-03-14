[[begin technical plan]]

[[begin invocation]]
We are going to do all of this from the linux command line. We are going to use
the following command

```
mediainfo --Output=JSON videofile.webm
```

to create a json output of the file. From there we will use a linux pipe to feed
the output json in a haskell execuable.
[[end invocation]]


[[begin haskell executable]]
the haskell executable is build using cabal.  it will make use of the aeson
library to parse the json. it will make use of the fmt library to create a
builder for the output.  It will make use of optparse-applicative to get the
file name of the video from user input, with a helpful cli based UI to respond
to errors and help requests
[[end haskell executable]]

[[begin sample input 1]]
{
"creatingLibrary":{"name":"MediaInfoLib","version":"24.12","url":"https://mediaarea.net/MediaInfo"},
"media":{"@ref":"/home/hippoid/videos/Rebuilding my NixOS config - Part 17： How to Use NixOS Specializations [fhE08-ZJ-Sk].webm","track":[{"@type":"General","VideoCount":"1",
"AudioCount":"1",
"MenuCount":"1",
"FileExtension":"webm",
"Format":"WebM",
"Format_Version":"4",
"FileSize":"117874810",
"Duration":"975.408",
"OverallBitRate":"966773",
"FrameRate":"30.000",
"FrameCount":"29261",
"IsStreamable":"Yes",
"File_Modified_Date":"2024-11-04 07:47:04 UTC",
"File_Modified_Date_Local":"2024-11-04 01:47:04",
"Encoded_Application":"Lavf61.7.100",
"Encoded_Library":"Lavf61.7.100"},{"@type":"Video","StreamOrder":"0",
"ID":"1",
"UniqueID":"17333972104246241731",
"Format":"VP9",
"Format_Profile":"0",
"CodecID":"V_VP9",
"Duration":"975.366000000",
"Width":"2560",
"Height":"1440",
"Sampled_Width":"2560",
"Sampled_Height":"1440",
"PixelAspectRatio":"1.000",
"DisplayAspectRatio":"1.778",
"FrameRate_Mode":"CFR",
"FrameRate":"30.000",
"FrameCount":"29261",
"ColorSpace":"YUV",
"ChromaSubsampling":"4:2:0",
"BitDepth":"8",
"Delay":"0.000",
"Delay_Source":"Container",
"Language":"en",
"Default":"Yes",
"Forced":"No",
"colour_description_present":"Yes",
"colour_description_present_Source":"Container",
"colour_range":"Limited",
"colour_range_Source":"Container / Stream",
"colour_primaries":"BT.709",
"colour_primaries_Source":"Container",
"transfer_characteristics":"BT.709",
"transfer_characteristics_Source":"Container",
"matrix_coefficients":"BT.709",
"matrix_coefficients_Source":"Container / Stream"},{"@type":"Audio","StreamOrder":"1",
"ID":"2",
"UniqueID":"17934552372420491549",
"Format":"Opus",
"CodecID":"A_OPUS",
"Duration":"975.401000000",
"Channels":"2",
"ChannelPositions":"Front: L R",
"ChannelLayout":"L R",
"SamplingRate":"48000",
"SamplingCount":"46819248",
"BitDepth":"32",
"Compression_Mode":"Lossy",
"Delay":"0.007",
"Delay_Source":"Container",
"Video_Delay":"0.007",
"Language":"en",
"Default":"Yes",
"Forced":"No"},{"@type":"Menu","extra":{"_00_00_00_000":"Introduction to NixOS Specializations","_00_01_04_000":"Setting Up Your First Specialization","_00_03_00_000":"Booting and Testing Specializations","_00_05_20_000":"Switching Between Specializations","_00_10_45_000":"Advanced Specialization Configurations","_00_10_54_000":"Practical Use Cases for Specializations","_00_13_35_000":"Checking Specialization Status","_00_15_21_000":"Conclusion and Final Thoughts"}}]}
}
[[end sample input 1]]

[[begin sample output 1]]
1   introduction to nixos specializations      00:00:00
2   setting up your first specialization       00:01:04
2   booting and testing specializations        00:03:00
4   switching between specializations          00:05:20
5   advanced specialization configurations     00:10:45
6   practical use cases for specializations    00:10:54
7   checking specialization status             00:13:35
8   conclusion and final thoughts              00:15:21
[[end sample input 1]]

[[begin sample input 2]]
{
"creatingLibrary":{"name":"MediaInfoLib","version":"24.12","url":"https://mediaarea.net/MediaInfo"},
"media":{"@ref":"/home/hippoid/videos/Improving Quality of Life with YubiKeys on NixOS [3CeXbONjIgE].webm","track":[{"@type":"General","VideoCount":"1",
"AudioCount":"1",
"MenuCount":"1",
"FileExtension":"webm",
"Format":"WebM",
"Format_Version":"4",
"FileSize":"182515611",
"Duration":"1291.068",
"OverallBitRate":"1130943",
"FrameRate":"30.000",
"FrameCount":"38732",
"IsStreamable":"Yes",
"File_Modified_Date":"2024-10-10 00:44:18 UTC",
"File_Modified_Date_Local":"2024-10-09 19:44:18",
"Encoded_Application":"Lavf61.7.100",
"Encoded_Library":"Lavf61.7.100"},{"@type":"Video","StreamOrder":"0",
"ID":"1",
"UniqueID":"8363614795069664182",
"Format":"VP9",
"Format_Profile":"0",
"CodecID":"V_VP9",
"Duration":"1291.066000000",
"Width":"2560",
"Height":"1440",
"Sampled_Width":"2560",
"Sampled_Height":"1440",
"PixelAspectRatio":"1.000",
"DisplayAspectRatio":"1.778",
"FrameRate_Mode":"CFR",
"FrameRate":"30.000",
"FrameCount":"38732",
"ColorSpace":"YUV",
"ChromaSubsampling":"4:2:0",
"BitDepth":"8",
"Delay":"0.000",
"Delay_Source":"Container",
"Language":"en",
"Default":"Yes",
"Forced":"No",
"colour_description_present":"Yes",
"colour_description_present_Source":"Container",
"colour_range":"Limited",
"colour_range_Source":"Container / Stream",
"colour_primaries":"BT.709",
"colour_primaries_Source":"Container",
"transfer_characteristics":"BT.709",
"transfer_characteristics_Source":"Container",
"matrix_coefficients":"BT.709",
"matrix_coefficients_Source":"Container / Stream"},{"@type":"Audio","StreamOrder":"1",
"ID":"2",
"UniqueID":"3357261617258377654",
"Format":"Opus",
"CodecID":"A_OPUS",
"Duration":"1291.061000000",
"Channels":"2",
"ChannelPositions":"Front: L R",
"ChannelLayout":"L R",
"SamplingRate":"48000",
"SamplingCount":"61970928",
"BitDepth":"32",
"Compression_Mode":"Lossy",
"Delay":"0.007",
"Delay_Source":"Container",
"Video_Delay":"0.007",
"Language":"en",
"Default":"Yes",
"Forced":"No"},{"@type":"Menu","extra":{"_00_00_00_000":"Introduction","_00_01_19_000":"YubiKey overview","_00_01_54_000":"Assumptions","_00_02_14_000":"Yubico apps we'll be using","_00_02_46_000":"Creating a YubiKey module","_00_04_26_000":"Setting a FIDO PIN for YubiKeys","_00_05_15_000":"Generating ssh keys for YubiKeys","_00_06_41_000":"Storing pub keys in nix-config and symlinking them","_00_07_53_000":"Declaring pub keys as authorized_keys","_00_08_32_000":"Storing private keys in nix-secrets, auto-extraction, and symlinking","_00_09_23_000":"Confirming public and private key symlinking","_00_10_35_000":"Handling multiple YubiKeys without the wait time","_00_13_13_000":"Associating the keys to hosts using ssh match blocks","_00_14_29_000":"Testing a passwordless ssh connection","_00_14_47_000":"Touch-based sudo using U2F","_00_16_58_000":"Testing touch-based sudo","_00_17_47_000":"Extras: Notifications when touch is requested","_00_19_08_000":"Extras: Git commit signing","_00_19_32_000":"Extras: LUKS2 decryption","_00_20_32_000":"Extras: Improved physical access to your YubiKey","_00_21_03_000":"Thank you!"}}]}
}
}
[[end sample input 2]]

[[begin sample output 2]]
Menu
1	introduction                                                              00:00:00.000
2	yubikey overview                                                          00:01:19.000
3	assumptions                                                               00:01:54.000
4	yubico apps we'll be using                                                00:02:14.000
6	creating a yubikey module                                                 00:02:46.000
7	setting a fido pin for yubikeys                                           00:04:26.000
8	generating ssh keys for yubikeys                                          00:05:15.000
9	storing pub keys in nix-config and symlinking them                        00:06:41.000
10	declaring pub keys as authorized_keys                                     00:07:53.000
11	storing private keys in nix-secrets, auto-extraction, and symlinking      00:08:32.000
12	confirming public and private key symlinking                              00:09:23.000
13	handling multiple yubikeys without the wait time                          00:10:35.000
14	associating the keys to hosts using ssh match blocks                      00:13:13.000
15	testing a passwordless ssh connection                                     00:14:29.000
16	touch-based sudo using u2f                                                00:14:47.000
17	testing touch-based sudo                                                  00:16:58.000
18	extras: notifications when touch is requested                             00:17:47.000
19	extras: git commit signing                                                00:19:08.000
20	extras: luks2 decryption                                                  00:19:32.000
21	extras: improved physical access to your yubikey                          00:20:32.000
22	thank you!                                                                00:21:03.000
[[end sample input 2]]

[[end technical plan]]
