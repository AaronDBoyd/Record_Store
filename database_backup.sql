--
-- PostgreSQL database dump
--

-- Dumped from database version 12.10
-- Dumped by pg_dump version 12.10

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
-- Name: albums; Type: TABLE; Schema: public; Owner: Aaron
--

CREATE TABLE public.albums (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public.albums OWNER TO "Aaron";

--
-- Name: albums_artists; Type: TABLE; Schema: public; Owner: Aaron
--

CREATE TABLE public.albums_artists (
    id integer NOT NULL,
    artist_id integer,
    album_id integer
);


ALTER TABLE public.albums_artists OWNER TO "Aaron";

--
-- Name: albums_artists_id_seq; Type: SEQUENCE; Schema: public; Owner: Aaron
--

CREATE SEQUENCE public.albums_artists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.albums_artists_id_seq OWNER TO "Aaron";

--
-- Name: albums_artists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Aaron
--

ALTER SEQUENCE public.albums_artists_id_seq OWNED BY public.albums_artists.id;


--
-- Name: albums_id_seq; Type: SEQUENCE; Schema: public; Owner: Aaron
--

CREATE SEQUENCE public.albums_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.albums_id_seq OWNER TO "Aaron";

--
-- Name: albums_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Aaron
--

ALTER SEQUENCE public.albums_id_seq OWNED BY public.albums.id;


--
-- Name: artists; Type: TABLE; Schema: public; Owner: Aaron
--

CREATE TABLE public.artists (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public.artists OWNER TO "Aaron";

--
-- Name: artists_id_seq; Type: SEQUENCE; Schema: public; Owner: Aaron
--

CREATE SEQUENCE public.artists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.artists_id_seq OWNER TO "Aaron";

--
-- Name: artists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Aaron
--

ALTER SEQUENCE public.artists_id_seq OWNED BY public.artists.id;


--
-- Name: songs; Type: TABLE; Schema: public; Owner: Aaron
--

CREATE TABLE public.songs (
    id integer NOT NULL,
    name character varying,
    album_id integer
);


ALTER TABLE public.songs OWNER TO "Aaron";

--
-- Name: songs_id_seq; Type: SEQUENCE; Schema: public; Owner: Aaron
--

CREATE SEQUENCE public.songs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.songs_id_seq OWNER TO "Aaron";

--
-- Name: songs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Aaron
--

ALTER SEQUENCE public.songs_id_seq OWNED BY public.songs.id;


--
-- Name: albums id; Type: DEFAULT; Schema: public; Owner: Aaron
--

ALTER TABLE ONLY public.albums ALTER COLUMN id SET DEFAULT nextval('public.albums_id_seq'::regclass);


--
-- Name: albums_artists id; Type: DEFAULT; Schema: public; Owner: Aaron
--

ALTER TABLE ONLY public.albums_artists ALTER COLUMN id SET DEFAULT nextval('public.albums_artists_id_seq'::regclass);


--
-- Name: artists id; Type: DEFAULT; Schema: public; Owner: Aaron
--

ALTER TABLE ONLY public.artists ALTER COLUMN id SET DEFAULT nextval('public.artists_id_seq'::regclass);


--
-- Name: songs id; Type: DEFAULT; Schema: public; Owner: Aaron
--

ALTER TABLE ONLY public.songs ALTER COLUMN id SET DEFAULT nextval('public.songs_id_seq'::regclass);


--
-- Data for Name: albums; Type: TABLE DATA; Schema: public; Owner: Aaron
--

COPY public.albums (id, name) FROM stdin;
2	Green
4	Dew
10	Pork Chop
11	Kezia
12	smurfs
13	chocolate rain
14	10,000 Days
15	IV
16	Lazy Dazeepicodus
17	lil porky 
18	Stinky Gurl
19	chocolate rain
3	Zarra
\.


--
-- Data for Name: albums_artists; Type: TABLE DATA; Schema: public; Owner: Aaron
--

COPY public.albums_artists (id, artist_id, album_id) FROM stdin;
1	4	2
2	3	2
3	3	2
5	5	10
6	4	11
7	6	11
8	4	3
9	4	12
10	7	14
11	8	15
12	9	11
13	10	3
14	11	2
15	12	11
16	12	16
17	3	18
18	10	13
\.


--
-- Data for Name: artists; Type: TABLE DATA; Schema: public; Owner: Aaron
--

COPY public.artists (id, name) FROM stdin;
3	Zara
4	KISS
7	Tool
9	Protest the Hero
10	Todd
11	Billy Idol
12	Duff MAn
13	Todd the hero
8	Red Zep
\.


--
-- Data for Name: songs; Type: TABLE DATA; Schema: public; Owner: Aaron
--

COPY public.songs (id, name, album_id) FROM stdin;
6	the dew	4
7	dew guy	4
9	the dew	2
10	dew guy	2
11	money	2
12	green giant	3
13	bacon	10
14	The Other Song	14
\.


--
-- Name: albums_artists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Aaron
--

SELECT pg_catalog.setval('public.albums_artists_id_seq', 18, true);


--
-- Name: albums_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Aaron
--

SELECT pg_catalog.setval('public.albums_id_seq', 19, true);


--
-- Name: artists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Aaron
--

SELECT pg_catalog.setval('public.artists_id_seq', 13, true);


--
-- Name: songs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Aaron
--

SELECT pg_catalog.setval('public.songs_id_seq', 15, true);


--
-- Name: albums_artists albums_artists_pkey; Type: CONSTRAINT; Schema: public; Owner: Aaron
--

ALTER TABLE ONLY public.albums_artists
    ADD CONSTRAINT albums_artists_pkey PRIMARY KEY (id);


--
-- Name: albums albums_pkey; Type: CONSTRAINT; Schema: public; Owner: Aaron
--

ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_pkey PRIMARY KEY (id);


--
-- Name: artists artists_pkey; Type: CONSTRAINT; Schema: public; Owner: Aaron
--

ALTER TABLE ONLY public.artists
    ADD CONSTRAINT artists_pkey PRIMARY KEY (id);


--
-- Name: songs songs_pkey; Type: CONSTRAINT; Schema: public; Owner: Aaron
--

ALTER TABLE ONLY public.songs
    ADD CONSTRAINT songs_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

