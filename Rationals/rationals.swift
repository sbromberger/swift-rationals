// swiftlint:disable identifier_name
struct Rational: Hashable {
    let num, den, g: Int
    private static func gcd(x: Int, y: Int) -> Int {
        return (y == 0) ? x : gcd(x: y, y: (x % y))
    }

    init() {
        (num, den, g) = (0, 1, 1)
    }

    init(numerator: Int, denominator: Int) {
        guard denominator != 0 else {
            fatalError("Rationals may not have a zero denominator")
        }

        let pg = abs(Rational.gcd(x: numerator, y: denominator))
        let denSign = denominator.signum()
        num = numerator * denSign / pg
        den = abs(denominator) / pg
        g = denSign * pg
    }

    init(_ numerator: Int, _ denominator: Int = 1) {
        self.init(numerator: numerator, denominator: denominator)
    }

    init(_ val: Int) {
        self.init(integerLiteral: val)
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

    init(_ s: String) {
        let f = s.split(separator: "/", maxSplits: 2, omittingEmptySubsequences: true)

        precondition(f.count == 2, "invalid string")
        let n: Int? = Int(f[0])
        let d: Int? = Int(f[1])

        precondition(n != nil && d != nil)
        self.init(numerator: n!, denominator: d!)
    }

    func inverse() -> Rational? {
        return Rational(den, num)
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
        return lhs.num == rhs.num && lhs.den == rhs.den
    }

    static func < (lhs: Rational, rhs: Rational) -> Bool {
        return lhs.num * rhs.den < lhs.den * rhs.num
    }
}

extension Rational: SignedNumeric {
    static func - (lhs: Rational, rhs: Rational) -> Rational {
        return lhs + -rhs
    }

    static func + (lhs: Rational, rhs: Rational) -> Rational {
        return Rational((lhs.num * rhs.den + rhs.num * lhs.den), lhs.den * rhs.den)
    }

    static func * (lhs: Rational, rhs: Rational) -> Rational {
        return Rational(lhs.num * rhs.num, lhs.den * rhs.den)
    }

    static func / (lhs: Rational, rhs: Rational) -> Rational {
        return Rational(lhs.num * rhs.den, lhs.den * rhs.num)
    }

    var magnitude: Rational {
        return Rational(abs(num), den)
    }

    init?<T>(exactly source: T) where T: BinaryInteger {
        self.init(Int(source), 1)
    }

    static func *= (lhs: inout Rational, rhs: Rational) {
        lhs = Rational(lhs.num * rhs.num, lhs.den * rhs.den)
    }

    static func += (lhs: inout Rational, rhs: Rational) {
        lhs = Rational((lhs.num * rhs.den + rhs.num * lhs.den), lhs.den * rhs.den)
    }

    static prefix func - (r: Rational) -> Rational {
        return Rational(-(r.num), r.den)
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
        return "\(num)//\(den)"
    }
}

extension Double {
    init(_ r: Rational) {
        self = Double(r.num) / Double(r.den)
    }
}

// let b = Rational(-10, -20)
// print(b)
// let c = Rational(numerator: 4, denominator: 5)
// print(c)
//
// let ba = b * c
// print(ba)
//
// let d = Rational()
// print(d)
//
// let s = Rational("9//8")
// print("s = \(s)")
//
//// let e = Rational(343, 0)
//
// let f = Rational()
// print("f = \(f)")
//
// var zzzzz = 2832.966
// let g = Rational(1, 5)
// print("g = \(g)")
//
// let h = Double(g)
// print("h = \(h)")
//
// let j = Rational(0.0248)
// print("j = \(j)")
//
// print(g > j)
//
// let k = g * 1
// print(k)
//
// let l: [Rational: String] = [j: "OK", g: "O2"]
// print(l)
//
// let m = Rational(0)
//
// let n = k / m
// print(n)
