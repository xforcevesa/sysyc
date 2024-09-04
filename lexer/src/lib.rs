use lalrpop_util::lalrpop_mod;

mod ast;
mod ast_impls;

lalrpop_mod!(arithmetic);


#[cfg(test)]
mod tests;
