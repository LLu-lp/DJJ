// Mock 数据 - 对接后端时替换为真实 API 调用

export const mockMovies = [
  { id: 1, title: '流浪地球3', poster: 'https://picsum.photos/seed/movie1/300/400', genre: ['科幻', '动作'], rating: 9.2, duration: 145, releaseDate: '2026-02-01', status: 'showing', boxOffice: 3280, description: '人类文明再次面临宇宙级别的危机，地球流浪计划进入最关键阶段。', director: '郭帆', actors: ['吴京', '刘德华', '李雪健'] },
  { id: 2, title: '哪吒之魔童闹海', poster: 'https://picsum.photos/seed/movie2/300/400', genre: ['动画', '奇幻'], rating: 9.5, duration: 130, releaseDate: '2026-01-29', status: 'showing', boxOffice: 5460, description: '哪吒化身战神，踏海而来，誓要改天换命。', director: '饺子', actors: ['哪吒', '敖丙'] },
  { id: 3, title: '长安三万里', poster: 'https://picsum.photos/seed/movie3/300/400', genre: ['动画', '历史'], rating: 8.8, duration: 168, releaseDate: '2025-12-01', status: 'showing', boxOffice: 1820, description: '以李白与高适的情谊为主线，呈现盛唐气象。', director: '谢君伟', actors: ['李白', '高适'] },
  { id: 4, title: '封神2', poster: 'https://picsum.photos/seed/movie4/300/400', genre: ['奇幻', '历史'], rating: 8.6, duration: 152, releaseDate: '2026-03-15', status: 'coming', boxOffice: 0, description: '商周之战进入白热化，姬发与纣王的最终对决。', director: '乌尔善', actors: ['费翔', '于适', '陈牧驰'] },
  { id: 5, title: '熊出没：重启未来', poster: 'https://picsum.photos/seed/movie5/300/400', genre: ['动画', '喜剧'], rating: 8.2, duration: 98, releaseDate: '2026-01-29', status: 'showing', boxOffice: 1640, description: '熊大熊二光头强携手穿越时空，守护森林家园。', director: '林汇达', actors: ['熊大', '熊二'] },
  { id: 6, title: '漫长的季节', poster: 'https://picsum.photos/seed/movie6/300/400', genre: ['悬疑', '犯罪'], rating: 9.0, duration: 138, releaseDate: '2026-02-20', status: 'coming', boxOffice: 0, description: '三个中年男人横跨十八年，追寻一桩埋藏已久的真相。', director: '辛爽', actors: ['范伟', '秦昊', '陈明昊'] },
]

export const mockCinemas = [
  { id: 1, name: '佳悦影院·万达店', address: '北京市朝阳区建国路93号万达广场5层', phone: '010-5588-6666', hallCount: 8, facilities: ['IMAX', '杜比', '4DX'], rating: 4.8 },
  { id: 2, name: '佳悦影院·三里屯店', address: '北京市朝阳区三里屯太古里北区L2', phone: '010-5588-7777', hallCount: 6, facilities: ['IMAX', 'CINITY'], rating: 4.9 },
  { id: 3, name: '佳悦影院·西单店', address: '北京市西城区西单北大街131号大悦城8层', phone: '010-5588-8888', hallCount: 5, facilities: ['杜比', 'RealD 3D'], rating: 4.7 },
]

export const mockSchedules = [
  { id: 1, movieId: 1, movieTitle: '流浪地球3', cinemaId: 1, cinemaName: '佳悦影院·万达店', hallName: 'IMAX厅', date: '2026-03-07', startTime: '10:00', endTime: '12:25', price: 95, remainingSeats: 68, totalSeats: 200, hallType: 'IMAX' },
  { id: 2, movieId: 1, movieTitle: '流浪地球3', cinemaId: 1, cinemaName: '佳悦影院·万达店', hallName: '1号厅', date: '2026-03-07', startTime: '13:30', endTime: '15:55', price: 65, remainingSeats: 102, totalSeats: 150, hallType: '普通' },
  { id: 3, movieId: 2, movieTitle: '哪吒之魔童闹海', cinemaId: 2, cinemaName: '佳悦影院·三里屯店', hallName: 'CINITY厅', date: '2026-03-07', startTime: '14:00', endTime: '16:10', price: 110, remainingSeats: 45, totalSeats: 120, hallType: 'CINITY' },
  { id: 4, movieId: 2, movieTitle: '哪吒之魔童闹海', cinemaId: 1, cinemaName: '佳悦影院·万达店', hallName: '2号厅', date: '2026-03-07', startTime: '16:30', endTime: '18:40', price: 68, remainingSeats: 88, totalSeats: 160, hallType: '普通' },
]

export const mockOrders = [
  { id: 'JY20260307001', movieTitle: '流浪地球3', cinemaName: '佳悦影院·万达店', hallName: 'IMAX厅', showTime: '2026-03-07 10:00', seats: ['F排8号', 'F排9号'], amount: 190, status: 'paid', createTime: '2026-03-06 20:30', snacks: [] },
  { id: 'JY20260306002', movieTitle: '哪吒之魔童闹海', cinemaName: '佳悦影院·三里屯店', hallName: 'CINITY厅', showTime: '2026-03-06 14:00', seats: ['C排5号'], amount: 110, status: 'used', createTime: '2026-03-05 18:00', snacks: [{ name: '爆米花(大)', price: 30 }] },
  { id: 'JY20260301003', movieTitle: '长安三万里', cinemaName: '佳悦影院·西单店', hallName: '1号厅', showTime: '2026-03-01 15:00', seats: ['D排10号', 'D排11号'], amount: 136, status: 'cancelled', createTime: '2026-02-28 10:00', snacks: [] },
]

export const mockSnacks = [
  { id: 1, name: '经典爆米花(大)', price: 35, originalPrice: 40, image: 'https://picsum.photos/seed/snack1/200/200', stock: 200, category: '爆米花', sales: 1520 },
  { id: 2, name: '焦糖爆米花(大)', price: 38, originalPrice: 42, image: 'https://picsum.photos/seed/snack2/200/200', stock: 150, category: '爆米花', sales: 980 },
  { id: 3, name: '可口可乐(大杯)', price: 18, originalPrice: 20, image: 'https://picsum.photos/seed/snack3/200/200', stock: 500, category: '饮品', sales: 2300 },
  { id: 4, name: '百事可乐(大杯)', price: 18, originalPrice: 20, image: 'https://picsum.photos/seed/snack4/200/200', stock: 450, category: '饮品', sales: 1800 },
  { id: 5, name: '套餐A（爆米花+饮料）', price: 48, originalPrice: 55, image: 'https://picsum.photos/seed/snack5/200/200', stock: 300, category: '套餐', sales: 3200 },
  { id: 6, name: '热狗', price: 22, originalPrice: 25, image: 'https://picsum.photos/seed/snack6/200/200', stock: 180, category: '小食', sales: 760 },
]

export const mockMember = {
  level: '黄金会员',
  points: 2580,
  discount: 0.9,
  totalConsume: 1280,
  joinDate: '2024-06-01',
  nextLevel: '钻石会员',
  nextLevelPoints: 5000,
}

export const mockMemberLevels = [
  { name: '普通会员', minPoints: 0, maxPoints: 499, discount: 1.0, color: '#8a93a8', icon: 'Medal' },
  { name: '白银会员', minPoints: 500, maxPoints: 1999, discount: 0.95, color: '#C0C0C0', icon: 'Star' },
  { name: '黄金会员', minPoints: 2000, maxPoints: 4999, discount: 0.9, color: '#e8b84b', icon: 'Trophy' },
  { name: '钻石会员', minPoints: 5000, maxPoints: null, discount: 0.85, color: '#4fc3f7', icon: 'Diamond' },
]

export const mockDashboardStats = {
  todayOrders: 328,
  todayBoxOffice: 32800,
  totalUsers: 12680,
  totalMovies: 86,
  weeklyBoxOffice: [
    { date: '03/01', amount: 28500 },
    { date: '03/02', amount: 31200 },
    { date: '03/03', amount: 26800 },
    { date: '03/04', amount: 35600 },
    { date: '03/05', amount: 42100 },
    { date: '03/06', amount: 38900 },
    { date: '03/07', amount: 32800 },
  ],
  movieTypeDistribution: [
    { name: '科幻', value: 18 },
    { name: '动作', value: 24 },
    { name: '爱情', value: 16 },
    { name: '动画', value: 12 },
    { name: '悬疑', value: 8 },
    { name: '喜剧', value: 20 },
    { name: '其他', value: 10 },
  ],
  boxOfficeByType: [
    { name: '科幻', amount: 12800 },
    { name: '动作', amount: 9600 },
    { name: '动画', amount: 8400 },
    { name: '爱情', amount: 5200 },
    { name: '喜剧', amount: 4800 },
    { name: '悬疑', amount: 3600 },
  ],
}
