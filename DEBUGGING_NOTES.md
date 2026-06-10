# Debugging and Device Setup Notes

## Module 95: Flutter DevTools
Flutter DevTools is essential for diagnosing app performance and UI issues.

### How to use:
1. Run the app in debug mode: `flutter run`
2. Open DevTools:
   - Click the link in the terminal (usually `http://127.0.0.1:XXXXX`).
   - Or run `flutter pub global run devtools` if configured globally.

### Key Sections:
- **Widget Inspector:** Visualize the widget tree and identify UI issues (e.g., overflows, layout problems).
- **Performance:** Monitor frame rates and identify performance bottlenecks.
- **Logs:** View console logs and network activity.

---

## Module 96: Real Android Device Testing

To test on a physical Android device:

### Prerequisites:
1. Enable **Developer Options** on your Android device.
2. Enable **USB Debugging** in Developer Options.
3. Connect the device via USB to your computer.

### Steps:
1. Verify the device is detected by Flutter:
   ```bash
   flutter devices
   ```
   (Your device should appear in the list)
2. Run the app on the device:
   ```bash
   flutter run
   ```
   (If multiple devices are connected, use `-d <device-id>`)
