#!/usr/bin/env swift
import Cocoa
import CoreGraphics
import Foundation

// MARK: - Configuration (Edit your defaults right here!)
struct Config {
    /// Path to the app icon (relative to project root or absolute)
    static var iconPath: String = "public/app-icon-1024.png"

    /// Main headline / title
    static var title: String = "Metaspero"

    /// Subtitle directly below the title
    static var subtitle: String = "PlayStation 5 Emulator for iOS & macOS"

    /// Summary description text
    static var description: String = "Open-source PS5 emulation with FEXCore ARM64 JIT, MoltenVK Metal backend & native SwiftUI."

    /// Tag badges shown beneath the description
    static var badges: [String] = [
        "iOS",
        "macOS",
        "Apple Silicon",
        "MoltenVK",
        "FEXCore"
    ]

    /// Output destination file for the generated image
    static var outputPath: String = "public/og-image.png"

    /// Standard Open Graph dimensions
    static let width: CGFloat = 1200
    static let height: CGFloat = 630
}

// MARK: - Project Path Resolution
let fileManager = FileManager.default

func findProjectRoot() -> URL {
    var candidate = URL(fileURLWithPath: CommandLine.arguments[0]).deletingLastPathComponent()
    if candidate.lastPathComponent == "scripts" {
        candidate = candidate.deletingLastPathComponent()
    }
    let pubDir = candidate.appendingPathComponent("public")
    if fileManager.fileExists(atPath: pubDir.path) {
        return candidate
    }
    let currentDir = URL(fileURLWithPath: fileManager.currentDirectoryPath)
    if fileManager.fileExists(atPath: currentDir.appendingPathComponent("public").path) {
        return currentDir
    }
    return candidate
}

let projectRoot = findProjectRoot()

func resolvePath(_ path: String) -> String {
    if path.hasPrefix("/") { return path }
    return projectRoot.appendingPathComponent(path).path
}

// Fallback to app-icon.png if 1024 doesn't exist
var resolvedIconPath = resolvePath(Config.iconPath)
if !fileManager.fileExists(atPath: resolvedIconPath) {
    let fallback = resolvePath("public/app-icon.png")
    if fileManager.fileExists(atPath: fallback) {
        resolvedIconPath = fallback
    }
}
var resolvedOutputPath = resolvePath(Config.outputPath)

// MARK: - Load Assets
guard fileManager.fileExists(atPath: resolvedIconPath) else {
    fputs("Error: Icon file not found at '\(resolvedIconPath)'\n", stderr)
    exit(1)
}

guard let iconImage = NSImage(contentsOfFile: resolvedIconPath) else {
    fputs("Error: Failed to load icon image from '\(resolvedIconPath)'\n", stderr)
    exit(1)
}

// MARK: - Render Canvas
let width = Int(Config.width)
let height = Int(Config.height)

guard let rep = NSBitmapImageRep(
    bitmapDataPlanes: nil,
    pixelsWide: width,
    pixelsHigh: height,
    bitsPerSample: 8,
    samplesPerPixel: 4,
    hasAlpha: true,
    isPlanar: false,
    colorSpaceName: .calibratedRGB,
    bytesPerRow: 0,
    bitsPerPixel: 0
) else {
    fputs("Error: Failed to initialize NSBitmapImageRep\n", stderr)
    exit(1)
}

rep.size = NSSize(width: width, height: height)

NSGraphicsContext.saveGraphicsState()
guard let context = NSGraphicsContext(bitmapImageRep: rep) else {
    fputs("Error: Failed to create NSGraphicsContext\n", stderr)
    exit(1)
}
NSGraphicsContext.current = context
context.imageInterpolation = .high

// 1. Dark Modern Background Gradient
let bgGradient = NSGradient(colors: [
    NSColor(red: 0.05, green: 0.05, blue: 0.07, alpha: 1.0),
    NSColor(red: 0.09, green: 0.10, blue: 0.14, alpha: 1.0)
])!
bgGradient.draw(in: NSRect(x: 0, y: 0, width: width, height: height), angle: -45)

// 2. Icon (positioned on the left, vertically centered)
let iconSize: CGFloat = 200
let iconX: CGFloat = 100
let iconY: CGFloat = CGFloat(height) / 2.0 - iconSize / 2.0

let iconShadow = NSShadow()
iconShadow.shadowColor = NSColor.black.withAlphaComponent(0.45)
iconShadow.shadowOffset = NSSize(width: 0, height: -8)
iconShadow.shadowBlurRadius = 24
iconShadow.set()

iconImage.draw(
    in: NSRect(x: iconX, y: iconY, width: iconSize, height: iconSize),
    from: NSRect(origin: .zero, size: iconImage.size),
    operation: .sourceOver,
    fraction: 1.0
)

// Clear Shadow for typography
NSShadow().set()

// 3. Typography & Badges
// In Cocoa coordinates, (0,0) is bottom-left, y increases upwards.
let textStartX: CGFloat = 345
let maxTextWidth: CGFloat = 780

// Title
let titleFont = NSFont.systemFont(ofSize: 58, weight: .bold)
let titleAttrs: [NSAttributedString.Key: Any] = [
    .font: titleFont,
    .foregroundColor: NSColor.white
]
let titlePoint = NSPoint(x: textStartX, y: 370)
(Config.title as NSString).draw(at: titlePoint, withAttributes: titleAttrs)

// Subtitle (positioned closely under the title)
let subFont = NSFont.systemFont(ofSize: 26, weight: .medium)
let subAttrs: [NSAttributedString.Key: Any] = [
    .font: subFont,
    .foregroundColor: NSColor(white: 0.80, alpha: 1.0)
]
let subPoint = NSPoint(x: textStartX, y: 325)
(Config.subtitle as NSString).draw(at: subPoint, withAttributes: subAttrs)

// Description paragraph
let descFont = NSFont.systemFont(ofSize: 18, weight: .regular)
let descParagraphStyle = NSMutableParagraphStyle()
descParagraphStyle.lineSpacing = 5
let descAttrs: [NSAttributedString.Key: Any] = [
    .font: descFont,
    .foregroundColor: NSColor(white: 0.54, alpha: 1.0),
    .paragraphStyle: descParagraphStyle
]

// Measure description text height dynamically
let descBoundingRect = (Config.description as NSString).boundingRect(
    with: NSSize(width: maxTextWidth, height: 160),
    options: [.usesLineFragmentOrigin, .usesFontLeading],
    attributes: descAttrs
)

// Place description top just below subtitle (subtitle baseline at 325 means its bottom is ~320)
let descTopY: CGFloat = 305
let descRect = NSRect(
    x: textStartX,
    y: descTopY - descBoundingRect.height,
    width: maxTextWidth,
    height: descBoundingRect.height
)
(Config.description as NSString).draw(with: descRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: descAttrs)

// 4. Badges (tight, natural spacing right below description)
if !Config.badges.isEmpty {
    let badgeSpacingFromDesc: CGFloat = 22
    let badgeHeight: CGFloat = 32
    let badgeY: CGFloat = descRect.origin.y - badgeSpacingFromDesc - badgeHeight
    
    var badgeX: CGFloat = textStartX
    for badge in Config.badges {
        let bFont = NSFont.systemFont(ofSize: 14, weight: .semibold)
        let bAttrs: [NSAttributedString.Key: Any] = [
            .font: bFont,
            .foregroundColor: NSColor(white: 0.88, alpha: 1.0)
        ]
        let strSize = (badge as NSString).size(withAttributes: bAttrs)
        let bRect = NSRect(x: badgeX, y: badgeY, width: strSize.width + 24, height: badgeHeight)
        let bPath = NSBezierPath(roundedRect: bRect, xRadius: 8, yRadius: 8)
        
        NSColor(white: 1.0, alpha: 0.08).setFill()
        bPath.fill()
        
        NSColor(white: 1.0, alpha: 0.15).setStroke()
        bPath.lineWidth = 1
        bPath.stroke()
        
        (badge as NSString).draw(at: NSPoint(x: badgeX + 12, y: badgeY + 7), withAttributes: bAttrs)
        badgeX += strSize.width + 34
        if badgeX > CGFloat(width) - 150 { break }
    }
}

NSGraphicsContext.restoreGraphicsState()

// MARK: - Save Output
guard let convertedRep = rep.converting(to: .sRGB, renderingIntent: .default),
      let pngData = convertedRep.representation(using: .png, properties: [:]) else {
    fputs("Error: Failed to convert image to PNG format\n", stderr)
    exit(1)
}

let destinationURL = URL(fileURLWithPath: resolvedOutputPath)
do {
    try fileManager.createDirectory(at: destinationURL.deletingLastPathComponent(), withIntermediateDirectories: true)
    try pngData.write(to: destinationURL)
    print("Successfully generated Open Graph image:")
    print("   Output:  \(destinationURL.path) (\(pngData.count / 1024) KB, \(width)x\(height))")
    print("   Icon:    \(resolvedIconPath)")
    print("   Title:   \"\(Config.title)\"")
    print("   Sub:     \"\(Config.subtitle)\"")
    print("   Badges:  \(Config.badges.joined(separator: ", "))")
} catch {
    fputs("Error: Failed to write output file: \(error.localizedDescription)\n", stderr)
    exit(1)
}
