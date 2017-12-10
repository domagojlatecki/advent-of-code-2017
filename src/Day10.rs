const NUM_VALUES: usize = 256;

fn main() {
    let args = ::std::env::args();
    let argv = args.size_hint().0;

    if argv != 2 {
        println!("One argument is expected");
        ::std::process::exit(1);
    }

    let skips_string = args.last().unwrap();
    let skips: Vec<&str> = skips_string.split(",").collect();
    let mut values: [usize; NUM_VALUES] = [0; NUM_VALUES];

    for i in 0..NUM_VALUES {
        values[i] = i;
    }

    let mut index: usize = 0;
    let mut skip_size: usize = 0;

    for length_string in skips {
        let length: usize = length_string.parse().unwrap();
        let end_index = index + length - 1;

        for i in index..end_index {
            let j = i % NUM_VALUES;
            let end = end_index - (i - index);
            let k = end % NUM_VALUES;

            if i >= end {
                break;
            }

            let tmp = values[j];

            values[j] = values[k];
            values[k] = tmp;
        }

        index += length + skip_size;
        skip_size += 1;
    }

    println!("{0}", values[0] * values[1]);
}
