// Bài 1: Sắp xếp mảng sau theo thứ tự độ tuổi giảm dần
const users = [
  { name: "name1", age: 12 },
  { name: "name2", age: 20 },
  { name: "name3", age: 15 },
  { name: "name4", age: 10 },
  { name: "name4", age: 27 },
];
users.sort((el1, el2) => el2.age - el1.age);
console.log(users);

// Bài 2: Viết code chuyển mảng đã sắp xếp ở bài 1 thành mảng tên
// VD: [‘name4’, ‘name2’, ‘name3’]
const result = [...new Set(users.map((element) => element.name))];
console.log(result);

// Bài 3: Tạo 1 mảng có 100 phần tử toàn bộ là số 0,
// chuyển mảng vừa tạo thành mảng mới có giá trị từ 0->99,
// lọc ra những số chia hết cho 5 rồi tính tổng những số còn lại
const originArray = new Array(100).fill(0);
let sum = 0;
result2 = originArray
  .map((el, i) => i)
  .filter((element) => {
    let result = element % 5 === 0;
    sum += !result ? element : 0;
    return result;
  });
console.log(result2);
console.log(sum);

// Bài 4: Cho mảng sau
const users3 = [
  { name: "name1", count: 13 },
  { name: "name3", count: 23 },
  { name: "name1", count: 25 },
  { name: "name2", count: 27 },
  { name: "name3", count: 30 },
  { name: "name2", count: 20 },
];

// Viết code nhóm các user có cùng name và cộng tổng số count thành một mảng mới
// VD:
// [
//   { name: 'name1', count: 38 },
//   { name: 'name3', count: 53 },
//   { name: 'name2', count: 47 }
// ]

const result4 = users3.reduce((pre, next) => {
  let index = pre.findIndex((value) => value.name === next.name);
  if (index !== -1) {
    pre[index].count += next.count;
  } else {
    pre.push(next);
  }
  return pre;
}, []);
console.log(result4);
