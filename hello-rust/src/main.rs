// //use error_chain::error_chain;
// //use std::io::Read;

// // error_chain! {
// //     foreign_links {
// //         Io(std::io::Error);
// //         HttpRequest(reqwest::Error);
// //     }
// // }

// fn main() {
//     println!("Hello, world!");

//     let mut res = reqwest::get("https://js.adapools.org/global.json");
//     let mut body = String::new();
//     res.read_to_string(&mut body);

//     println!("Status: {}", res.status());
//     println!("Headers:\n{:#?}", res.headers());
//     println!("Body:\n{}", body);
// }

use std::collections::HashMap;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let resp = reqwest::blocking::get("https://httpbin.org/ip")?
        .json::<HashMap<String, String>>()?;
    println!("{:#?}", resp);
    Ok(())
}