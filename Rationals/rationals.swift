// swiftlint:disable identifier_name
struct Rational: Hashable {
    let numerator, denominator, divisor: Int
    private static func gcd(x: Int, y: Int) -> Int {
        return (y == 0) ? x : gcd(x: y, y: (x % y))
    }

    init() {
        (numerator, denominator, divisor) = (0, 1, 1)
    }

    init(numerator: Int, denominator: Int) {
        guard denominator != 0 else {
            fatalError("Rationals may not have a zero denominator")
        }

        let pg = abs(Rational.gcd(x: numerator, y: denominator))
        let denSign = denominator.signum()
        self.numerator = numerator * denSign / pg
        self.denominator = abs(denominator) / pg
        self.divisor = denSign * pg
    }

    init(_ numerator: Int, _ denominator:Int) {
        self.init(numerator: numerator, denominator: denominator)
    }

    init(_ v: Double) {
        var d = 1
        var n = v
        while Double(Int(n)) != n {
            d *= 10
            n = n * 10
        }
        self.init(numerator: Int(n), denominator: d)
    }

    init?(_ s: String) {
        let f = s.split(separator: "/", maxSplits: 2, omittingEmptySubsequences: true)

        if (f.count != 2) {
            return nil
        }

        let n: Int? = Int(f[0])
        let d: Int? = Int(f[1])
        if (n != nil && d != nil) {
            self.init(numerator: n!, denominator: d!)
        }
        return nil
    }

    var inverse: Rational {
        return Rational(denominator, numerator)
    }
}

extension Rational: ExpressibleByIntegerLiteral {
    init(integerLiteral value: Int) {
        self.init(value, 1)
    }
}

extension Rational: ExpressibleByFloatLiteral {
    init(floatLiteral value: Double) {
        self.init(value)
    }
}

extension Rational: Comparable {
    static func == (lhs: Rational, rhs: Rational) -> Bool {
        return lhs.numerator == rhs.numerator && lhs.denominator == rhs.denominator
    }

    static func < (lhs: Rational, rhs: Rational) -> Bool {
        return lhs.numerator * rhs.denominator < lhs.denominator * rhs.numerator
    }
}

extension Rational: SignedNumeric {
    static func - (lhs: Rational, rhs: Rational) -> Rational {
        return lhs + -rhs
    }

    static func + (lhs: Rational, rhs: Rational) -> Rational {
        return Rational((lhs.numerator * rhs.denominator + rhs.numerator * lhs.denominator), lhs.denominator * rhs.denominator)
    }

    static func * (lhs: Rational, rhs: Rational) -> Rational {
        return Rational(lhs.numerator * rhs.numerator, lhs.denominator * rhs.denominator)
    }

    static func / (lhs: Rational, rhs: Rational) -> Rational {
        return Rational(lhs.numerator * rhs.denominator, lhs.denominator * rhs.numerator)
    }

    var magnitude: Rational {
        return Rational(abs(numerator), denominator)
    }

    init?<T>(exactly source: T) where T: BinaryInteger {
        self.init(Int(source), 1)
    }

    static func *= (lhs: inout Rational, rhs: Rational) {
        lhs = Rational(lhs.numerator * rhs.numerator, lhs.denominator * rhs.denominator)
    }

    static func += (lhs: inout Rational, rhs: Rational) {
        lhs = Rational((lhs.numerator * rhs.denominator + rhs.numerator * lhs.denominator), lhs.denominator * rhs.denominator)
    }

    static prefix func - (r: Rational) -> Rational {
        return Rational(-(r.numerator), r.denominator)
    }

    mutating func negate() {
        self = -self
    }

    static func -= (lhs: inout Rational, rhs: Rational) {
        lhs += -rhs
    }
}

extension Rational: Strideable {
    func advanced(by n: Rational) -> Rational {
        return self + n
    }

    func distance(to other: Rational) -> Rational {
        return other - self
    }
}

extension Rational: CustomStringConvertible {
    var description: String {
        return "\(numerator)//\(denominator)"
    }
}

extension Double {
    init(_ r: Rational) {
        self = Double(r.numerator) / Double(r.denominator)
    }
}

 let b = Rational(-10, -20)
 print(b)
 let c = Rational(numerator: 4, denominator: 5)
 print(c)

 let ba = b * c
 print(ba)

 let d = Rational()
 print(d)

 let s = Rational("9//8")
 print("s = \(s)")

// let e = Rational(343, 0)

 let f = Rational()
 print("f = \(f)")

 var zzzzz = 2832.966
 let g = Rational(1, 5)
 print("g = \(g)")

 let h = Double(g)
 print("h = \(h)")

 let j = Rational(0.0248)
 print("j = \(j)")

 print(g > j)

 let k = g * 1
 print(k)

 let l: [Rational: String] = [j: "OK", g: "O2"]
 print(l)

 let m = Rational(0)

//let im = m.inverse
//if im == nil {
//    print("im is nil")
//} else {
//    print("im = \(im)")
//}
// let n = k / m
// print(n)

let p = Rational("3")
if p == nil {
    print("p is nil")
}
