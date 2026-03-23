wit_bindgen::generate!({
    path: "../world.wit",
});

struct Component;
export!(Component);

impl Guest for Component {
    fn plus1(val: u32) -> u32 {
        val + 1
    }
}
