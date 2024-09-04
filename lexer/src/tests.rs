use super::*;

pub fn parse_expression(input: &str) -> Result<i64, String> {
    let parser = arithmetic::ArithmeticParser::new();
    parser.parse(input).map_err(|e| e.to_string())
}

#[test]
fn test_lalrpop_arithmetic() {
    assert_eq!(
        parse_expression("3 + 5 * (10 - 2)").unwrap(),
        43
    );
}