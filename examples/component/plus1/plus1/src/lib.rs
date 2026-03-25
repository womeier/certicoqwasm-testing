wit_bindgen::generate!({
    path: "../world.wit",
});

struct Component;
export!(Component);

impl Guest for Component {
    fn plus1(val: u64) -> u64 {
        val + 1
    }
}
