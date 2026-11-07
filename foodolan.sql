--
-- PostgreSQL database dump
--

\restrict xLfWxeyZHafHxoQgy6WEYno0i78TuME6vsBn9mScklalllUHYge4kMXJnlCjjMN

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: FoodPlan; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "FoodPlan" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'ru';


ALTER DATABASE "FoodPlan" OWNER TO postgres;

\unrestrict xLfWxeyZHafHxoQgy6WEYno0i78TuME6vsBn9mScklalllUHYge4kMXJnlCjjMN
\connect "FoodPlan"
\restrict xLfWxeyZHafHxoQgy6WEYno0i78TuME6vsBn9mScklalllUHYge4kMXJnlCjjMN

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: meal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meal (
    id integer NOT NULL,
    meal text
);


ALTER TABLE public.meal OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.meal.id;


--
-- Name: dishes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dishes (
    id integer NOT NULL,
    dish text,
    calories real,
    proteins real,
    fats real,
    carbohydrates real
);


ALTER TABLE public.dishes OWNER TO postgres;

--
-- Name: dishes_meal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dishes_meal (
    id integer NOT NULL,
    id_dishes integer,
    id_meal integer
);


ALTER TABLE public.dishes_meal OWNER TO postgres;

--
-- Name: dishes_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dishes_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dishes_categories_id_seq OWNER TO postgres;

--
-- Name: dishes_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dishes_categories_id_seq OWNED BY public.dishes_meal.id;


--
-- Name: dishes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dishes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dishes_id_seq OWNER TO postgres;

--
-- Name: dishes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dishes_id_seq OWNED BY public.dishes.id;


--
-- Name: drinks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.drinks (
    id integer NOT NULL,
    drink text,
    proteins real,
    fats real,
    carbohydrates real,
    calories real
);


ALTER TABLE public.drinks OWNER TO postgres;

--
-- Name: drinks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.drinks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.drinks_id_seq OWNER TO postgres;

--
-- Name: drinks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.drinks_id_seq OWNED BY public.drinks.id;


--
-- Name: menu_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu_items (
    id integer NOT NULL,
    id_menu_plans integer,
    day integer,
    id_meal integer,
    id_dishes integer
);


ALTER TABLE public.menu_items OWNER TO postgres;

--
-- Name: menu_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.menu_items_id_seq OWNER TO postgres;

--
-- Name: menu_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.menu_items_id_seq OWNED BY public.menu_items.id;


--
-- Name: menu_plans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu_plans (
    id integer NOT NULL,
    id_user integer,
    daily_calories integer NOT NULL,
    start_date date,
    end_date date
);


ALTER TABLE public.menu_plans OWNER TO postgres;

--
-- Name: menu_plans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_plans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.menu_plans_id_seq OWNER TO postgres;

--
-- Name: menu_plans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.menu_plans_id_seq OWNED BY public.menu_plans.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    full_name text,
    gender text,
    age integer,
    weight real,
    height real,
    physical_activity_level integer,
    login text,
    password text
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: dishes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dishes ALTER COLUMN id SET DEFAULT nextval('public.dishes_id_seq'::regclass);


--
-- Name: dishes_meal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dishes_meal ALTER COLUMN id SET DEFAULT nextval('public.dishes_categories_id_seq'::regclass);


--
-- Name: drinks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drinks ALTER COLUMN id SET DEFAULT nextval('public.drinks_id_seq'::regclass);


--
-- Name: meal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meal ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: menu_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_items ALTER COLUMN id SET DEFAULT nextval('public.menu_items_id_seq'::regclass);


--
-- Name: menu_plans id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_plans ALTER COLUMN id SET DEFAULT nextval('public.menu_plans_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: dishes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dishes (id, dish, calories, proteins, fats, carbohydrates) FROM stdin;
1	Борщ с капустой и картофелем на мясном бульоне	49	1.9	2.5	4.6
2	Борщ вегетарианский	30	1	0.1	6.1
3	Суп-харчо из говядины	75	3.4	4.2	5.8
4	Суп куриный с макаронными изделиями	50	3.1	2.1	4.6
5	Суп гороховый на костном бульоне	66	4.1	2.3	7.3
6	Суп гороховый с копченостями	81	4.8	3.9	6.9
7	Рассольник ленинградский на мясном бульоне	51	2	2.4	5.4
8	Солянка сборная мясная	89	5.1	6.7	2.2
9	Щи из свежей капусты с картофелем на мясном бульоне	38	1.7	2.1	3.1
10	Щи из квашеной капусты со свининой	56	2.8	4.4	2.1
11	Суп картофельный с фрикадельками	58	3.2	3.1	4.3
12	Суп из овощей сборных вегетарианский	28	0.9	0.1	5.7
13	Суп-пюре из шампиньонов	78	1.9	5.8	4.5
14	Суп-пюре из тыквы со сливками	54	1.2	3.1	5.3
15	Уха ростовская	42	4.8	1.3	2.7
16	Окрошка мясная сборная (на квасе)	62	4.4	3.5	3.3
17	Окрошка овощная на кефире	47	2.6	2.1	4.4
18	Свекольник холодный	30	1.2	0.1	6
19	Суп из чечевицы	68	4.5	1.8	8.5
20	Суп молочный с макаронными изделиями	71	2.8	2.5	9.3
21	Суп щавелевый с яйцом	40	2.2	2.4	2.5
22	Бульон куриный прозрачный	15	1.8	0.8	0.1
23	Суп сырный с курицей	91	4.8	6.2	4
24	Суп картофельный с крупой (рисовый)	44	1.6	1.3	6.4
25	Суп-лапша домашняя на курином бульоне	55	3.4	2.3	5.1
26	Котлеты, биточки домашние жареные (говядина+свинина)	253	13.8	19.1	6.5
27	Котлеты из говядины паровые	142	16.4	7.8	1.5
28	Гуляш из говядины с подливой	154	14.2	9.8	3.1
29	Бефстроганов из говядины	182	14.8	12.6	2.8
30	Жаркое по-домашнему со свининой	172	10.1	11.8	8.5
31	Азу из говядины	128	12.4	7.1	4.2
32	Свинина тушеная с луком	248	13.5	21.2	1.1
33	Плов с говядиной	208	8.4	9.5	22.1
34	Плов с курицей	182	10.5	7.2	18.8
35	Голубцы с мясом и рисом тушеные	122	6.8	8.1	6.4
36	Голубцы ленивые мясные	114	7.2	7	6.1
37	Тефтели мясные в томатном соусе	151	10.2	10.1	4.8
38	Ежики из говядины с рисом	144	10.8	8.4	6.3
39	Мясо по-французски (запеченное с сыром и майонезом)	210	12.8	15.4	5.1
40	Поджарка из свинины	295	14.1	26.3	0.4
41	Шницель свиной отварной	234	17.2	18.1	0.6
42	Курица запеченная (в духовке)	191	21.4	11.5	0.5
43	Куриное филе на гриле	145	27.2	3.8	0.4
44	Котлеты куриные пожарские	198	14.5	12.2	7.6
45	Котлеты из индейки на пару	128	18.4	4.9	2.6
46	Печень говяжья, тушеная в сметане	138	15.6	6.4	4.5
47	Сердца куриные тушеные	141	14.2	8.9	1
48	Чахохбили из курицы	112	12.8	5.8	2.1
49	Рагу из кролика тушеное	134	17.1	6.8	1.1
50	Язык говяжий отварной	146	15.1	9.4	0
51	Шашлык из свиной шеи	272	14.8	23.6	0.1
52	Фарш, обжаренный с луком (говяжий)	218	17.5	16.1	0.8
53	Перец, фаршированный мясом и рисом	106	5.8	6.5	6.1
54	Макароны по-флотски с мясным фаршем	194	8.9	7.8	22
55	Шакшука (яичница с томатами и перцем)	114	6.2	8.6	3.8
56	Рыба белая (треска), отварная	74	16.2	0.9	0
57	Минтай запеченный с луком	82	15.4	1.8	1.1
58	Котлеты рыбные из трески жареные	145	13.2	6.9	7.4
59	Семга на пару	197	21.2	12.5	0
60	Горбуша запеченная под майонезом	176	19.1	10.4	1.3
61	Рыбные фрикадельки в томатном соусе	108	11.5	4.8	4.7
62	Кальмары отварные	100	18	2.2	2
63	Креветки отварные	95	19	1	1.2
64	Судак запеченный в сметанном соусе	124	16.1	5.4	2.8
65	Рыба, жаренная в тесте (в кляре)	228	13.4	12.1	16.3
66	Гречневая каша рассыпчатая на воде без масла	102	4.1	1	21.2
67	Гречневая каша со сливочным маслом	134	3.8	4.8	20.3
68	Рис отварной (белый)	114	2.4	0.2	25.6
69	Рис бурый отварной	111	2.6	0.8	23.4
70	Макаронные изделия отварные без масла	128	4.5	0.5	26.4
71	Пюре картофельное с молоком и маслом	108	2.2	4.2	15.3
72	Картофель отварной	82	2	0.4	16.7
73	Картофель, запеченный в духовке	104	2.2	2.1	19.1
74	Картофель жареный на растительном масле	192	2.6	9.5	23.4
75	Капуста тушеная на масле	61	2	3.1	6.3
76	Овощное рагу (кабачки, баклажаны, перец)	48	1.3	2.2	5.8
77	Пшенная каша на воде плотная	90	3	0.7	18
78	Пшенная каша молочная жидкая с сахаром	116	3.2	3	19.1
79	Овсяная каша "Геркулес" молочная	105	3.4	3.2	15.6
80	Овсяная каша на воде без сахара	65	2.2	1	11.8
81	Рисовая каша молочная сладкая	102	2.6	2.8	16.6
82	Манная каша молочная	114	3.1	3.6	17.3
83	Каша кукурузная на молоке	98	2.7	2.2	16.8
84	Перловая каша рассыпчатая	106	3.1	0.4	22.5
85	Ячневая каша вязкая	84	2.3	0.3	18.1
86	Гороховое пюре	118	8.2	0.9	19.3
87	Лобо (тушеная красная фасоль)	124	6.2	3.8	16.2
88	Чечевица отварная	112	7.8	0.5	19.1
89	Булгур отварной	108	3.4	0.4	22.7
90	Кускус отварной	115	3.8	0.2	24.5
91	Киноа отварная	120	4.4	1.9	21.3
92	Брокколи отварная	35	2.4	0.4	5.4
93	Цветная капуста жареная в сухарях	102	3	5.6	9.8
94	Кабачки, жаренные кружочками	85	1.2	6.1	6.3
95	Шампиньоны, жаренные с луком	69	2.6	5.1	3.2
96	Салат Оливье с вареной колбасой	192	5.2	16.4	6
97	Салат Оливье с курицей	134	7.8	8.2	6.3
98	Салат Сельдь под шубой	198	5.8	15.9	8
99	Салат Мимоза со свежей консервированной рыбой	228	8.1	18.6	7
100	Салат Цезарь с курицей	178	12.1	11.8	5.8
101	Салат Греческий	118	3.2	10.1	3.6
102	Винегрет овощной с растительным маслом	86	1.4	5.1	8.6
103	Салат из свежих огурцов и помидоров с маслом	62	0.8	5.2	3
104	Салат из огурцов и помидоров со сметаной 15%	41	1.1	2.3	3.2
105	Салат Крабовый с кукурузой и майонезом	158	4.8	10.8	10.4
106	Салат Витаминный (капуста, морковь, масло)	56	1.4	2.8	6.3
107	Морковь по-корейски	115	1.1	8.3	9
108	Салат свекольный с чесноком и майонезом	126	1.7	9.5	8.4
109	Салат свекольный с черносливом и грецким орехом	148	2.4	8.6	15.3
110	Салат из морской капусты с яйцом и майонезом	84	3.1	6.2	2.9
111	Салат с тунцом, яйцом и огурцом (без майонеза)	106	13.1	5.4	1.3
112	Фунчоза с овощами	138	1.3	4.9	22.1
113	Салат Капрезе (томаты с моцареллой)	162	8.5	13.1	2.5
114	Салат из редиса со сметаной и яйцом	58	2.6	3.8	2.8
115	Чука салат с ореховым соусом	139	1.6	9.8	11.1
116	Яичница-глазунья на масле (из 2 яиц)	182	12.1	14.3	0.6
117	Омлет натуральный на молоке жареный	148	9.6	11.2	1.9
118	Омлет со шпинатом	124	8.4	9.3	1.6
119	Сырники из творога 5% запеченные	191	16.1	5.8	18.6
120	Сырники из творога 9% жареные	246	14.3	12.2	19.7
121	Запеканка творожная со сметаной	211	13.8	8.1	20.6
122	Ленивые вареники из творога сладкие	194	11.2	4.4	27.3
123	Яйцо пашот	143	12.6	10	0.7
124	Овсяноблин (базовый рецепт)	162	8.1	6.4	18
125	Тост с авокадо	178	3.9	9.2	19.8
126	Пельмени мясные отварные	248	11.2	12.8	21.9
127	Вареники с картофелем отварные	165	3.6	2.7	31.5
128	Вареники с творогом отварные	215	10.1	4.9	32.5
129	Манты с говядиной на пару	215	9.8	10.4	20.5
130	Хинкали отварные классические	205	9.2	9.4	20.9
131	Блины классические без начинки	231	6	8.1	33.4
132	Блины с начинкой из отварного мяса	195	9.4	8.2	21
133	Блины с творожной начинкой	188	8.1	5.6	26.2
134	Оладьи на кефире	258	5.6	8.6	39.5
135	Оладьи из кабачков жареные	99	2.2	5.1	11
136	Гренки из пшеничного хлеба с яйцом	218	7	8.8	27.6
137	Пицца Маргарита	238	9.8	8.6	30.4
138	Пицца Пепперони	279	11.9	12.2	30.5
139	Пирожок с капустой печеный	197	4.6	3.2	37.4
140	Пирожок с мясом жареный	291	9.2	13.9	32.1
141	Чебурек с мясом	319	10.1	17.2	31
142	Хачапури по-аджарски	282	12.1	13.6	28.1
143	Рулет из лаваша со слабосоленой рыбой	178	10.2	7.4	17.6
144	Бутерброд с сыром и маслом	318	9.5	20.1	24.8
145	Жюльен с курицей и грибами	158	12.1	11.2	3
146	Холодец из говядины	80	14.5	2.5	0.1
147	Заливное из рыбы (судак)	50	9.5	1	0.7
148	Икра кабачковая обжаренная	84	1.1	5.1	7.3
149	Форшмак из сельди классический	188	9.2	15.2	3.9
150	Шарлотка с яблоками домашняя	177.3	3.9	2.6	34
\.


--
-- Data for Name: dishes_meal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dishes_meal (id, id_dishes, id_meal) FROM stdin;
21	1	2
22	2	2
23	3	2
24	4	2
25	5	2
26	6	2
27	7	2
28	8	2
29	9	2
30	10	2
31	11	2
32	12	2
33	13	2
34	14	2
35	15	2
36	16	2
37	17	2
38	18	2
39	19	2
40	20	2
41	21	2
42	22	2
43	23	2
44	24	2
45	25	2
46	26	2
47	26	3
48	27	2
49	27	3
50	28	2
51	28	3
52	29	2
53	29	3
54	30	2
55	30	3
56	31	2
57	31	3
58	32	2
59	32	3
60	33	2
61	33	3
62	34	2
63	34	3
64	35	2
65	35	3
66	36	2
67	36	3
68	37	2
69	37	3
70	38	2
71	38	3
72	39	2
73	39	3
74	40	2
75	40	3
76	41	2
77	41	3
78	42	2
79	42	3
80	43	2
81	43	3
82	44	2
83	44	3
84	45	2
85	45	3
86	46	2
87	46	3
88	47	2
89	47	3
90	48	2
91	48	3
92	49	2
93	49	3
94	50	2
95	50	3
96	51	2
97	51	3
98	52	2
99	52	3
100	53	2
101	53	3
102	54	2
103	54	3
104	55	2
105	55	3
106	56	1
107	56	2
108	56	3
109	56	5
110	57	1
111	57	2
112	57	3
113	57	5
114	58	1
115	58	2
116	58	3
117	58	5
118	59	1
119	59	2
120	59	3
121	59	5
122	60	1
123	60	2
124	60	3
125	60	5
126	61	1
127	61	2
128	61	3
129	61	5
130	62	1
131	62	2
132	62	3
133	62	5
134	63	1
135	63	2
136	63	3
137	63	5
138	64	1
139	64	2
140	64	3
141	64	5
142	65	1
143	65	2
144	65	3
145	65	5
146	66	2
147	66	3
148	66	5
149	67	2
150	67	3
151	67	5
152	68	2
153	68	3
154	68	5
155	69	2
156	69	3
157	69	5
158	70	2
159	70	3
160	70	5
161	71	2
162	71	3
163	71	5
164	72	2
165	72	3
166	72	5
167	73	2
168	73	3
169	73	5
170	74	2
171	74	3
172	74	5
173	75	2
174	75	3
175	75	5
176	76	2
177	76	3
178	76	5
179	77	2
180	77	3
181	77	5
182	78	2
183	78	3
184	78	5
185	79	2
186	79	3
187	79	5
188	80	2
189	80	3
190	80	5
191	81	2
192	81	3
193	81	5
194	82	2
195	82	3
196	82	5
197	83	2
198	83	3
199	83	5
200	84	2
201	84	3
202	84	5
203	85	2
204	85	3
205	85	5
206	86	2
207	86	3
208	86	5
209	87	2
210	87	3
211	87	5
212	88	2
213	88	3
214	88	5
215	89	2
216	89	3
217	89	5
218	90	2
219	90	3
220	90	5
221	91	2
222	91	3
223	91	5
224	92	2
225	92	3
226	92	5
227	93	2
228	93	3
229	93	5
230	94	2
231	94	3
232	94	5
233	95	2
234	95	3
235	95	5
236	96	1
237	96	5
238	97	1
239	97	5
240	98	1
241	98	5
242	99	1
243	99	5
244	100	1
245	100	5
246	101	1
247	101	5
248	102	1
249	102	5
250	103	1
251	103	5
252	104	1
253	104	5
254	105	1
255	105	5
256	106	1
257	106	5
258	107	1
259	107	5
260	108	1
261	108	5
262	109	1
263	109	5
264	110	1
265	110	5
266	111	1
267	111	5
268	112	1
269	112	5
270	113	1
271	113	5
272	114	1
273	114	5
274	115	1
275	115	5
276	116	1
277	116	5
278	117	1
279	117	5
280	118	1
281	118	5
282	119	1
283	119	5
284	120	1
285	120	5
286	121	1
287	121	5
288	122	1
289	122	5
290	123	1
291	123	5
292	124	1
293	124	5
294	125	1
295	125	5
296	126	1
297	126	3
298	126	5
299	127	1
300	127	3
301	127	5
302	128	1
303	128	3
304	128	5
305	129	1
306	129	3
307	129	5
308	130	1
309	130	3
310	130	5
311	131	1
312	131	3
313	131	5
314	132	1
315	132	3
316	132	5
317	133	1
318	133	3
319	133	5
320	134	1
321	134	3
322	134	5
323	135	1
324	135	3
325	135	5
326	136	1
327	136	3
328	136	5
329	137	1
330	137	3
331	137	5
332	138	1
333	138	3
334	138	5
335	139	1
336	139	3
337	139	5
338	140	1
339	140	3
340	140	5
341	141	1
342	141	3
343	141	5
344	142	1
345	142	3
346	142	5
347	143	1
348	143	3
349	143	5
350	144	1
351	144	3
352	144	5
353	145	1
354	145	3
355	145	5
356	146	1
357	146	3
358	146	5
359	147	1
360	147	3
361	147	5
362	148	1
363	148	3
364	148	5
365	149	1
366	149	3
367	149	5
368	150	1
369	150	3
370	150	5
\.


--
-- Data for Name: drinks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.drinks (id, drink, proteins, fats, carbohydrates, calories) FROM stdin;
3	кефир 2,5%	2.8	3.2	4.1	55.9
4	кисель апельсиновый	2.7	2.1	18	97.8
5	кисель брусничный	0.07	0.05	19.9	75.2
6	кисель клюквенный	0.05	0.02	14.7	55.4
7	коктейль молочный	2.9	4.3	12.5	96.6
1	какао с молоком	2.9	2.9	17.2	102.8
8	компот из вишни	0.3	0.08	13.7	53.5
9	компот из сухофруктов	0.3	0	14.5	55.6
10	кофе с молоком	1.4	1.5	12.1	64.1
2	квас хлебный	0.2	0	5.2	27
11	чай черный без сахара	0.1	0	0	1
12	чай черный с сахаром	0.1	0	5	22
13	чай зеленый с сахаром	0	0.2	5.7	24
14	чай зеленый без сахара	0	0	0	1
15	Coca-Cola	0	0	10.6	42
\.


--
-- Data for Name: meal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meal (id, meal) FROM stdin;
1	завтрак
2	обед
3	ужин
5	перекус
\.


--
-- Data for Name: menu_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu_items (id, id_menu_plans, day, id_meal, id_dishes) FROM stdin;
1	1	1	1	288
2	1	1	2	8
3	1	1	5	226
\.


--
-- Data for Name: menu_plans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu_plans (id, id_user, daily_calories, start_date, end_date) FROM stdin;
1	1	1724	2026-11-02	2026-11-08
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, full_name, gender, age, weight, height, physical_activity_level, login, password) FROM stdin;
1	Голубева Марина Андреевна	жен	22	50	164	2	admin	123456
2	Иванов Иван Иванович	муж	21	80	166	1	1111	234
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 5, true);


--
-- Name: dishes_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dishes_categories_id_seq', 370, true);


--
-- Name: dishes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dishes_id_seq', 150, true);


--
-- Name: drinks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.drinks_id_seq', 15, true);


--
-- Name: menu_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_items_id_seq', 3, true);


--
-- Name: menu_plans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_plans_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: meal categories_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meal
    ADD CONSTRAINT categories_pk PRIMARY KEY (id);


--
-- Name: dishes_meal dishes_meal_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dishes_meal
    ADD CONSTRAINT dishes_meal_pk PRIMARY KEY (id);


--
-- Name: dishes dishes_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dishes
    ADD CONSTRAINT dishes_pk PRIMARY KEY (id);


--
-- Name: drinks drinks_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drinks
    ADD CONSTRAINT drinks_pk PRIMARY KEY (id);


--
-- Name: menu_items menu_items_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_items
    ADD CONSTRAINT menu_items_pk PRIMARY KEY (id);


--
-- Name: menu_plans menu_plans_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_plans
    ADD CONSTRAINT menu_plans_pk PRIMARY KEY (id);


--
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


--
-- Name: dishes_meal dishes_meal_meal_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dishes_meal
    ADD CONSTRAINT dishes_meal_meal_fk FOREIGN KEY (id_meal) REFERENCES public.meal(id);


--
-- Name: menu_items menu_items_meal_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_items
    ADD CONSTRAINT menu_items_meal_fk FOREIGN KEY (id_meal) REFERENCES public.meal(id);


--
-- Name: menu_items menu_items_menu_plans_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_items
    ADD CONSTRAINT menu_items_menu_plans_fk FOREIGN KEY (id_menu_plans) REFERENCES public.menu_plans(id);


--
-- Name: menu_plans menu_plans_users_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_plans
    ADD CONSTRAINT menu_plans_users_fk FOREIGN KEY (id_user) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict xLfWxeyZHafHxoQgy6WEYno0i78TuME6vsBn9mScklalllUHYge4kMXJnlCjjMN

