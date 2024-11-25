This layer enables IMX219 camera sensor ISP support on IMX8MP for single or dual camera setups.

A sample DTS (`imx8mp-evk-imx219.dts`) is added to `linux-imx`.

### Steps
- Add this layer to your yocto project
- Compile a system image for your board
    - `$ bitbake ${image}`

- Plug imx219 sensor to the board MIPI CSI1/2 connectors
- Flash a Micro SD card with the system image
- Boot the board
- Run the ISP server configuration in background:
    - Single camera: `/opt/imx8-isp/bin/run.sh -lm -c imx219_1080p60 &`
    - Dual camera: `/opt/imx8-isp/bin/run.sh -lm -c dual_imx219_1080p60 &`
- Test with gstreamer:
```
gst-launch-1.0 -e -v \
        v4l2src device=/dev/video3 ! \
                "video/x-raw,format=YUY2,width=1920,height=1080,framerate=(fraction)30/1" ! \
        queue ! \
        imxvideoconvert_g2d ! \
        v4l2h264enc ! \
        h264parse ! \
        qtmux ! \
        filesink location="output.mp4"
```

### Hailo compatibility

Since `v4.16.0`, Hailo has introduced the new `hailonetv2` element, streamlined as `hailonet` in `v4.17.0`,
which uses a zero-copy mechanism that does **not** work when used IMX ISP devices with `v4l2src`.

To work around this issue, please use the legacy `synchailonet` element if needed.