--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-06-09 03:29:14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- TOC entry 215 (class 1259 OID 57809)
-- Name: cars; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cars (
    car_id integer NOT NULL,
    year_model numeric NOT NULL,
    make character varying(50) NOT NULL,
    model character varying(40) NOT NULL,
    category character varying(20) NOT NULL,
    plate character varying(15) NOT NULL,
    available boolean NOT NULL
);


ALTER TABLE public.cars OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 57818)
-- Name: cars_car_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cars_car_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cars_car_id_seq OWNER TO postgres;

--
-- TOC entry 4869 (class 0 OID 0)
-- Dependencies: 218
-- Name: cars_car_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cars_car_id_seq OWNED BY public.cars.car_id;


--
-- TOC entry 216 (class 1259 OID 57812)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    customer_id integer NOT NULL,
    name character varying(50) NOT NULL,
    phone character varying(25) NOT NULL,
    country character varying(30) DEFAULT 'BRAZIL'::character varying NOT NULL,
    email character varying(60)
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 57830)
-- Name: customers_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customers_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_customer_id_seq OWNER TO postgres;

--
-- TOC entry 4870 (class 0 OID 0)
-- Dependencies: 219
-- Name: customers_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customers_customer_id_seq OWNED BY public.customers.customer_id;


--
-- TOC entry 217 (class 1259 OID 57815)
-- Name: rentals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rentals (
    rental_id integer NOT NULL,
    customer_id integer,
    car_id integer,
    date_rented date DEFAULT now() NOT NULL,
    date_returned date
);


ALTER TABLE public.rentals OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 57841)
-- Name: rentals_rental_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rentals_rental_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rentals_rental_id_seq OWNER TO postgres;

--
-- TOC entry 4871 (class 0 OID 0)
-- Dependencies: 220
-- Name: rentals_rental_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rentals_rental_id_seq OWNED BY public.rentals.rental_id;


--
-- TOC entry 4698 (class 2604 OID 57819)
-- Name: cars car_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cars ALTER COLUMN car_id SET DEFAULT nextval('public.cars_car_id_seq'::regclass);


--
-- TOC entry 4699 (class 2604 OID 57831)
-- Name: customers customer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN customer_id SET DEFAULT nextval('public.customers_customer_id_seq'::regclass);


--
-- TOC entry 4701 (class 2604 OID 57842)
-- Name: rentals rental_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentals ALTER COLUMN rental_id SET DEFAULT nextval('public.rentals_rental_id_seq'::regclass);


--
-- TOC entry 4858 (class 0 OID 57809)
-- Dependencies: 215
-- Data for Name: cars; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cars (car_id, year_model, make, model, category, plate, available) FROM stdin;
1	2000	Toyota	Corolla	SUBCOMPACT	ABC123	t
2	2001	Honda	Civic	MID-SIZE	DEF456	t
3	2002	Ford	Fiesta	SUBCOMPACT	GHI789	t
4	2003	Chevrolet	Cruze	COMPACT	JKL012	t
5	2004	Hyundai	Elantra	COMPACT	MNO345	t
6	2005	Toyota	Yaris	SUBCOMPACT	PQR678	t
7	2006	Honda	Accord	MID-SIZE	STU901	t
8	2007	Ford	Fusion	COMPACT	VWX234	t
9	2008	Chevrolet	Impala	FULL-SIZE	YZ01AB	t
10	2009	Nissan	Altima	MID-SIZE	BC234D	t
11	2010	Toyota	Corolla	SUBCOMPACT	EFG567	t
12	2011	Honda	Civic	MID-SIZE	HIJ890	t
13	2012	Ford	Fiesta	SUBCOMPACT	KLM123	t
14	2013	Chevrolet	Cruze	COMPACT	NOP456	t
15	2014	Hyundai	Elantra	COMPACT	QRS789	t
16	2015	Toyota	Yaris	SUBCOMPACT	TUV012	t
17	2016	Honda	Accord	MID-SIZE	WXY345	t
18	2017	Ford	Fusion	COMPACT	Z01AB2	t
19	2018	Chevrolet	Impala	FULL-SIZE	CD345E	t
20	2019	Nissan	Altima	MID-SIZE	FG678H	t
21	2020	Toyota	Corolla	SUBCOMPACT	GH901I	t
22	2021	Honda	Civic	MID-SIZE	JKL234	t
23	2022	Ford	Fiesta	SUBCOMPACT	MNO567	t
24	2023	Chevrolet	Cruze	COMPACT	PQR890	t
25	2024	Hyundai	Elantra	COMPACT	STU123	t
26	2005	Toyota	Corolla	SUBCOMPACT	ABC456	t
27	2010	Honda	Civic	MID-SIZE	DEF789	t
28	2015	Ford	Fiesta	SUBCOMPACT	GHI012	t
29	2020	Chevrolet	Cruze	COMPACT	JKL345	t
30	2009	Hyundai	Elantra	COMPACT	MNO678	t
31	2012	Toyota	Yaris	SUBCOMPACT	PQR901	t
32	2017	Honda	Accord	MID-SIZE	STU234	t
33	2023	Ford	Fusion	COMPACT	VWX567	t
34	2016	Nissan	Altima	MID-SIZE	YZ0123	t
35	2022	Toyota	Corolla	SUBCOMPACT	BC3456	t
36	2014	Honda	Civic	MID-SIZE	DEF678	t
37	2007	Ford	Fiesta	SUBCOMPACT	GHI901	t
38	2013	Chevrolet	Cruze	COMPACT	JKK234	t
39	2019	Hyundai	Elantra	COMPACT	MNP567	t
40	2024	Toyota	Yaris	SUBCOMPACT	PQR880	t
\.


--
-- TOC entry 4859 (class 0 OID 57812)
-- Dependencies: 216
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (customer_id, name, phone, country, email) FROM stdin;
1	Hayley Zamora	1-350-925-4842	Singapore\r	proin@aol.ca
2	Brenda Noble	1-276-589-9929	United States\r	nullam.lobortis.quam@outlook.com
3	Martena Jenkins	(772) 197-3584	South Korea\r	tellus.id@hotmail.com
4	Berk Buck	1-612-536-7610	Canada\r	cras.pellentesque@aol.net
5	Ralph Crawford	1-821-999-9438	Germany\r	fusce@protonmail.org
6	Macaulay Compton	1-127-418-7578	United States\r	maecenas.mi@outlook.com
7	Carla Daniel	(842) 473-3367	Belgium\r	diam@icloud.edu
8	Knox Schroeder	(136) 816-8714	Peru\r	praesent.eu@protonmail.org
9	Jack Hubbard	1-652-388-6362	Singapore\r	lacinia@icloud.com
10	Henry Bauer	(137) 316-8563	France\r	dictum@google.edu
11	Aimee Mooney	1-727-176-2681	Poland\r	posuere.vulputate@aol.org
12	Mollie Maddox	1-527-460-2570	Vietnam\r	vitae.aliquet.nec@icloud.com
13	Mollie Hooper	1-401-717-7483	Austria\r	dui.fusce@google.couk
14	Lois Kramer	1-263-504-1164	Peru\r	quis.diam@aol.couk
15	Phillip Gray	1-721-653-0544	South Africa\r	eget.ipsum@protonmail.couk
16	Flynn Price	(358) 811-7716	Australia\r	sed.est@hotmail.com
17	Nolan Oneil	1-475-956-5668	Italy\r	maecenas.mi.felis@hotmail.org
18	Emerald Rowland	1-673-757-3781	Netherlands\r	nunc.ullamcorper@hotmail.ca
19	Xena Garner	1-844-217-4138	China\r	nunc.nulla@icloud.com
20	Basil Sellers	(726) 690-3058	United Kingdom\r	id@protonmail.edu
21	Regan Silva	(567) 434-1368	Indonesia\r	nec@aol.org
22	Holly Cardenas	1-729-311-5186	Pakistan\r	cras.convallis@protonmail.ca
23	Geoffrey Summers	(403) 160-9539	Austria\r	etiam.ligula.tortor@aol.edu
24	Carla Brewer	(621) 540-9656	Pakistan\r	condimentum.eget@aol.net
25	Kylie James	(888) 264-0844	China\r	adipiscing.mauris.molestie@icloud.com
26	Reese House	1-617-894-4589	Austria\r	rutrum.fusce.dolor@protonmail.ca
27	Dolan Petty	(213) 784-6392	Poland\r	aliquam.eros@hotmail.com
28	Abel Nelson	(256) 235-6430	Nigeria\r	et.tristique@google.couk
29	Barrett Phillips	(498) 473-2842	Belgium\r	accumsan.convallis@yahoo.net
30	Adrian Hobbs	(205) 740-7536	Poland\r	integer.sem@protonmail.ca
31	Lareina Serrano	1-478-710-6616	France\r	erat.eget.ipsum@outlook.org
32	Leigh Jacobs	1-516-648-7510	Germany\r	enim.sit@yahoo.org
33	Lucian Carter	1-533-333-1658	Italy\r	iaculis.nec@hotmail.ca
34	Jescie Slater	(601) 454-7408	Pakistan\r	ligula.tortor@icloud.net
35	Xantha Clarke	(339) 724-9584	United States\r	cubilia@outlook.com
36	Venus Valenzuela	(849) 531-5296	Italy\r	enim.curabitur.massa@protonmail.edu
37	Oliver Wyatt	1-443-548-2478	Ireland\r	lacinia.sed@outlook.edu
38	Damon Stanley	(854) 161-4746	Sweden\r	vulputate@yahoo.couk
39	Austin Kemp	1-212-438-2251	Turkey\r	malesuada.malesuada@yahoo.net
40	Macy Skinner	1-534-581-5874	Poland\r	nulla.semper.tellus@google.edu
41	Merritt Cox	(671) 389-0834	Austria\r	aenean@google.com
42	Dominique Mathis	1-165-934-3127	China\r	dictum.phasellus.in@outlook.org
43	Vera Ryan	(727) 824-1558	Philippines\r	magnis.dis@yahoo.com
44	Lionel Tillman	(761) 826-2419	Brazil\r	lorem.lorem.luctus@yahoo.couk
45	Paloma Figueroa	1-521-657-4685	Norway\r	sed.hendrerit.a@hotmail.edu
46	Jael Barrera	(822) 236-2983	Sweden\r	magna.nam@hotmail.com
47	Lillian Stein	1-771-119-5848	Ireland\r	curabitur.vel@google.couk
48	Hilel Anthony	(313) 443-3956	Ireland\r	duis@protonmail.org
49	Garrett George	1-992-684-8281	Peru\r	molestie.tellus@hotmail.ca
50	Seth Herrera	(322) 756-5141	Mexico\r	risus.in.mi@hotmail.ca
51	Miranda Robles	(127) 813-6341	Poland\r	faucibus@hotmail.couk
52	Kirk James	(688) 265-9632	Belgium\r	vitae.aliquet.nec@outlook.com
53	Grant Dunlap	(773) 128-4862	New Zealand\r	vivamus.nisi.mauris@yahoo.edu
54	Gwendolyn Arnold	1-320-544-0426	India\r	diam.proin@protonmail.couk
55	Joel Price	1-464-435-9634	Sweden\r	interdum@yahoo.ca
56	Beau Chavez	(481) 965-5917	Spain\r	ligula.donec@yahoo.edu
57	Beau Wise	(610) 391-6661	Australia\r	a.feugiat.tellus@google.couk
58	Jeanette Harrison	1-853-841-5288	United Kingdom\r	et@google.net
59	Ivan Michael	1-193-290-5500	United Kingdom\r	volutpat.ornare@google.couk
60	Alexis Clark	(854) 554-6687	China\r	eu.lacus.quisque@yahoo.org
61	Kyla Nolan	(755) 513-2641	Ireland\r	mauris.blandit.enim@aol.org
62	Erasmus Barnett	(397) 421-3471	Germany\r	mollis@hotmail.com
63	Sylvester Shields	(277) 772-9177	United States\r	placerat.orci@protonmail.org
64	Olga Rasmussen	(671) 925-7762	Turkey\r	magna.et.ipsum@google.edu
65	Jennifer Medina	(503) 712-6441	Pakistan\r	arcu@outlook.ca
66	Chiquita Pittman	(225) 848-4296	Poland\r	enim.mauris@yahoo.ca
67	Paloma Richard	(551) 378-3691	Chile\r	aliquam@yahoo.edu
68	Garrison Middleton	(344) 156-4065	Brazil\r	interdum.nunc@aol.ca
69	Ivana Payne	1-795-506-4610	Belgium\r	vestibulum.ante.ipsum@outlook.couk
70	Tanek Mendoza	1-152-257-0872	Mexico\r	est@hotmail.com
71	Kirsten Stephenson	(148) 327-5228	Chile\r	integer.mollis@protonmail.org
72	Dai Humphrey	1-728-536-6020	Russian Federation\r	leo.in@protonmail.edu
73	Chelsea Serrano	(458) 949-4801	Belgium\r	odio.tristique@protonmail.org
74	Kamal Garrett	1-618-830-7774	Austria\r	nisi@protonmail.ca
75	Gabriel Ferrell	(426) 582-8243	Ireland\r	et.pede@aol.edu
76	Chester Valentine	(248) 533-5312	Germany\r	cras.dolor@aol.com
77	Tanya Cantrell	(562) 384-9559	New Zealand\r	consequat.dolor@protonmail.ca
78	Kasimir Pope	1-718-367-5944	South Korea\r	metus.in@google.org
79	Jayme Cobb	(640) 814-7261	Turkey\r	ultrices.sit@outlook.couk
80	Kevyn Burgess	(117) 801-6144	Colombia\r	duis@yahoo.couk
81	Noah Hamilton	(841) 283-9065	United Kingdom\r	cursus.integer@icloud.org
82	Breanna Morin	1-834-871-5717	Nigeria\r	aenean@outlook.edu
83	Allen Harvey	(348) 643-1468	Netherlands\r	justo.praesent@yahoo.edu
84	Sonya Strickland	1-768-455-8111	Austria\r	aliquam.ornare.libero@outlook.org
85	Simon Mccall	(485) 693-2111	Philippines\r	turpis.nulla.aliquet@yahoo.org
86	Idona Wilkins	(870) 519-1281	Brazil\r	ipsum.ac@yahoo.ca
87	Dorothy Moore	(468) 329-7153	France\r	velit.in.aliquet@google.edu
88	Linda Coleman	(534) 148-5922	Sweden\r	sed@yahoo.org
89	Gail Jimenez	1-186-531-3426	Italy\r	arcu.eu@protonmail.com
90	Connor Spencer	(612) 517-6673	Mexico\r	odio@hotmail.ca
91	Dillon Mcknight	(444) 270-1980	Poland\r	ornare.tortor@protonmail.com
92	Channing Fletcher	1-570-253-8019	Philippines\r	proin.non@hotmail.com
93	Hashim Waters	(447) 380-7831	Spain\r	elit.a@icloud.ca
94	Veda Tucker	1-692-366-3663	Australia\r	elementum.lorem@outlook.ca
95	Nerea Rivas	(733) 980-1072	France\r	tempus.non.lacinia@outlook.ca
96	Simon Landry	(859) 121-8820	Nigeria\r	class.aptent@icloud.edu
97	Xavier Orr	1-132-234-2859	New Zealand\r	quis.diam@yahoo.net
98	Madison Dean	(726) 720-5523	Poland\r	nostra.per@icloud.edu
99	Geraldine Watson	1-419-421-3246	Spain\r	ut.lacus@aol.couk
\.


--
-- TOC entry 4860 (class 0 OID 57815)
-- Dependencies: 217
-- Data for Name: rentals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rentals (rental_id, customer_id, car_id, date_rented, date_returned) FROM stdin;
\.


--
-- TOC entry 4872 (class 0 OID 0)
-- Dependencies: 218
-- Name: cars_car_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cars_car_id_seq', 3, true);


--
-- TOC entry 4873 (class 0 OID 0)
-- Dependencies: 219
-- Name: customers_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_customer_id_seq', 24, true);


--
-- TOC entry 4874 (class 0 OID 0)
-- Dependencies: 220
-- Name: rentals_rental_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rentals_rental_id_seq', 13, true);


--
-- TOC entry 4704 (class 2606 OID 57821)
-- Name: cars cars_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_pkey PRIMARY KEY (car_id);


--
-- TOC entry 4706 (class 2606 OID 57829)
-- Name: cars cars_plate_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_plate_key UNIQUE (plate);


--
-- TOC entry 4708 (class 2606 OID 57839)
-- Name: customers customers_phone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_phone_key UNIQUE (phone);


--
-- TOC entry 4710 (class 2606 OID 57833)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- TOC entry 4712 (class 2606 OID 57844)
-- Name: rentals rentals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentals
    ADD CONSTRAINT rentals_pkey PRIMARY KEY (rental_id);


--
-- TOC entry 4713 (class 2606 OID 57854)
-- Name: rentals fk_car_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentals
    ADD CONSTRAINT fk_car_id FOREIGN KEY (car_id) REFERENCES public.cars(car_id);


--
-- TOC entry 4714 (class 2606 OID 57849)
-- Name: rentals fk_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentals
    ADD CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


-- Completed on 2024-06-09 03:29:15

--
-- PostgreSQL database dump complete
--

