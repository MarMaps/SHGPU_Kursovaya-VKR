--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

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

\connect "FoodPlan"

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
    dish text NOT NULL,
    calories integer,
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
    physical_activity_level integer
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
12	Суп харчо	75	3.5	4	6
13	Суп из чечевицы	56	3.5	1.5	7
14	Суп с фрикадельками	58	4	2.5	5
15	Суп-пюре из брокколи	38	2	2	3.5
16	Каша гречневая	110	4.2	1.8	20
17	Каша овсяная на молоке	102	3.2	3.2	14.5
18	Каша рисовая на молоке	97	2.8	3	14
19	Каша пшенная	119	3.5	3.2	19.5
20	Каша перловая	109	3.1	0.9	22
1	Борщ	65	2.8	3.1	5.5
2	Щи	32	1.5	1.8	3
3	Солянка мясная	95	6	6.5	3.5
4	Суп куриный с лапшой	45	3	1.5	5
5	Рассольник	42	2	1.8	4.5
6	Уха	48	6	1.5	2.5
7	Окрошка на квасе	57	2.5	2.8	5
8	Окрошка на кефире	65	3.5	3	5.5
9	Гороховый суп	66	4.5	2.5	7
10	Грибной суп	32	1.8	1.5	3
11	Суп-пюре из тыквы	48	1.2	2.2	6
\.


--
-- Data for Name: dishes_meal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dishes_meal (id, id_dishes, id_meal) FROM stdin;
1	1	2
2	2	2
3	3	2
4	4	3
5	5	3
6	6	2
7	7	2
8	8	2
9	9	3
10	10	3
11	11	2
12	12	2
13	13	3
14	14	2
15	15	2
16	16	3
17	17	1
18	18	1
19	19	1
20	20	3
\.


--
-- Data for Name: meal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meal (id, meal) FROM stdin;
1	завтрак
2	обед
3	ужин
\.


--
-- Data for Name: menu_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu_items (id, id_menu_plans, day, id_meal, id_dishes) FROM stdin;
\.


--
-- Data for Name: menu_plans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu_plans (id, id_user, daily_calories, start_date, end_date) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, full_name, gender, age, weight, height, physical_activity_level) FROM stdin;
1	Голубева Марина Андреевна	жен	22	50	164	2
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 4, true);


--
-- Name: dishes_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dishes_categories_id_seq', 20, true);


--
-- Name: dishes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dishes_id_seq', 201, true);


--
-- Name: menu_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_items_id_seq', 1, false);


--
-- Name: menu_plans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_plans_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


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
-- Name: dishes dishes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dishes
    ADD CONSTRAINT dishes_pkey PRIMARY KEY (id);


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
-- Name: dishes_meal dishes_meal_dishes_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dishes_meal
    ADD CONSTRAINT dishes_meal_dishes_fk FOREIGN KEY (id_dishes) REFERENCES public.dishes(id);


--
-- Name: dishes_meal dishes_meal_meal_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dishes_meal
    ADD CONSTRAINT dishes_meal_meal_fk FOREIGN KEY (id_meal) REFERENCES public.meal(id);


--
-- Name: menu_items menu_items_dishes_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_items
    ADD CONSTRAINT menu_items_dishes_fk FOREIGN KEY (id_dishes) REFERENCES public.dishes(id);


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

