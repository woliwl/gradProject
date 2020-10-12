const now = function(){
    var date = new Date(),
    year = date.getFullYear(),
    month = date.getMonth() + 1,
    day = date.getDate(),
    hour = date.getHours() < 10 ? "0" + date.getHours() : date.getHours(),
    minute = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
    month >= 1 && month <= 9 ? (month = "0" + month) : "";
    day >= 0 && day <= 9 ? (day = "0" + day) : "";
    var timer = year + '-' + month + '-' + day + ' ' + hour + ':' + minute;
    return timer;
}
const dateDay = function(type) {
    const date = new Date();
    let year = date.getFullYear();
    let month = date.getMonth() + 1;
    let day = date.getDate();
    
    if (type === 'start') {
        year = year - 60;
    } else if (type === 'end') {
        year = year + 2;
    }
    month = month > 9 ? month : '0' + month;;
    day = day > 9 ? day : '0' + day;
    return `${year}-${month}-${day}`;  
}
export default {  
    now,
    dateDay
}