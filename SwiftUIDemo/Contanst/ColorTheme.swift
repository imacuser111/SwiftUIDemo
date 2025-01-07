import SwiftUI

protocol ColorTheme {
    var colorsError500: Color { get }
    var colorsGrayScale0: Color { get }
    var colorsGrayScale50: Color { get }
    var colorsGrayScale100: Color { get }
    var colorsGrayScale150: Color { get }
    var colorsGrayScale200: Color { get }
    var colorsGrayScale300: Color { get }
    var colorsGrayScale400: Color { get }
    var colorsGrayScale500: Color { get }
    var colorsGrayScale600: Color { get }
    var colorsGrayScale700: Color { get }
    var colorsGrayScale800: Color { get }
    var colorsGrayScale850: Color { get }
    var colorsGrayScale900: Color { get }
    var colorsGrayScale1000: Color { get }
    var colorsPrimary150: Color { get }
    var colorsPrimary500: Color { get }
    var colorsSuccess500: Color { get }
    var colorsSuccess600: Color { get }
    var colorsBlack30: Color { get }
    var colorsLogo500: Color { get }
}

struct LightColorTheme: ColorTheme {
    let colorsError500: Color = Color(hex: "#FFC13515")
    let colorsGrayScale0: Color = Color(hex: "#FFFFFFFF")
    let colorsGrayScale50: Color = Color(hex: "#FFF9F9F9")
    let colorsGrayScale100: Color = Color(hex: "#FFE5E5E5")
    let colorsGrayScale150: Color = Color(hex: "#FFD7D7D7")
    let colorsGrayScale200: Color = Color(hex: "#FFCACACA")
    let colorsGrayScale300: Color = Color(hex: "#FFB0B0B0")
    let colorsGrayScale400: Color = Color(hex: "#FF959595")
    let colorsGrayScale500: Color = Color(hex: "#FF7B7B7B")
    let colorsGrayScale600: Color = Color(hex: "#FF626262")
    let colorsGrayScale700: Color = Color(hex: "#FF4C4C4C")
    let colorsGrayScale800: Color = Color(hex: "#FF313131")
    let colorsGrayScale850: Color = Color(hex: "#FF222222")
    let colorsGrayScale900: Color = Color(hex: "#FF191919")
    let colorsGrayScale1000: Color = Color(hex: "#FF000000")
    let colorsPrimary150: Color = Color(hex: "#FFF8C0D3")
    let colorsPrimary500: Color = Color(hex: "#FFE72E6B")
    let colorsSuccess500: Color = Color(hex: "#FF26BC7D")
    let colorsSuccess600: Color = Color(hex: "#FF1E9664")
    let colorsBlack30: Color = Color(hex: "#4C000000")
    let colorsLogo500: Color = Color(hex: "#FFFF5B5B")
}

struct DarkColorTheme: ColorTheme {
    let colorsError500: Color = Color(hex: "#FFC13515")
    let colorsGrayScale0: Color = Color(hex: "#FFFFFFFF")
    let colorsGrayScale50: Color = Color(hex: "#FFF9F9F9")
    let colorsGrayScale100: Color = Color(hex: "#FFE5E5E5")
    let colorsGrayScale150: Color = Color(hex: "#FFD7D7D7")
    let colorsGrayScale200: Color = Color(hex: "#FFCACACA")
    let colorsGrayScale300: Color = Color(hex: "#FFB0B0B0")
    let colorsGrayScale400: Color = Color(hex: "#FF959595")
    let colorsGrayScale500: Color = Color(hex: "#FF7B7B7B")
    let colorsGrayScale600: Color = Color(hex: "#FF626262")
    let colorsGrayScale700: Color = Color(hex: "#FF4C4C4C")
    let colorsGrayScale800: Color = Color(hex: "#FF313131")
    let colorsGrayScale850: Color = Color(hex: "#FF222222")
    let colorsGrayScale900: Color = Color(hex: "#FF191919")
    let colorsGrayScale1000: Color = Color(hex: "#FF000000")
    let colorsPrimary150: Color = Color(hex: "#FFF8C0D3")
    let colorsPrimary500: Color = Color(hex: "#FFE72E6B")
    let colorsSuccess500: Color = Color(hex: "#FF26BC7D")
    let colorsSuccess600: Color = Color(hex: "#FF1E9664")
    let colorsBlack30: Color = Color(hex: "#4C000000")
    let colorsLogo500: Color = Color(hex: "#FFFF5B5B")
}
