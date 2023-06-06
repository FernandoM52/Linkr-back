--
-- PostgreSQL database dump
--

-- Dumped from database version 13.9 (Ubuntu 13.9-1.pgdg20.04+1)
-- Dumped by pg_dump version 14.8 (Ubuntu 14.8-0ubuntu0.22.04.1)

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

ALTER TABLE IF EXISTS ONLY public.sessions DROP CONSTRAINT IF EXISTS sessions_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.posts DROP CONSTRAINT IF EXISTS posts_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.posts_hashtag DROP CONSTRAINT IF EXISTS posts_hashtag_posts_id_fkey;
ALTER TABLE IF EXISTS ONLY public.posts_hashtag DROP CONSTRAINT IF EXISTS posts_hashtag_hashtags_id_fkey;
ALTER TABLE IF EXISTS ONLY public.likes DROP CONSTRAINT IF EXISTS likes_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.likes DROP CONSTRAINT IF EXISTS likes_post_id_fkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_email_key;
ALTER TABLE IF EXISTS ONLY public.trendings DROP CONSTRAINT IF EXISTS trendings_pkey;
ALTER TABLE IF EXISTS ONLY public.sessions DROP CONSTRAINT IF EXISTS sessions_token_key;
ALTER TABLE IF EXISTS ONLY public.sessions DROP CONSTRAINT IF EXISTS sessions_pkey;
ALTER TABLE IF EXISTS ONLY public.posts DROP CONSTRAINT IF EXISTS posts_pkey;
ALTER TABLE IF EXISTS ONLY public.posts_hashtag DROP CONSTRAINT IF EXISTS posts_hashtag_pkey;
ALTER TABLE IF EXISTS ONLY public.likes DROP CONSTRAINT IF EXISTS likes_pkey;
ALTER TABLE IF EXISTS public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.trendings ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sessions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.posts_hashtag ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.posts ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.likes ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.users_id_seq;
DROP TABLE IF EXISTS public.users;
DROP SEQUENCE IF EXISTS public.trendings_id_seq;
DROP TABLE IF EXISTS public.trendings;
DROP SEQUENCE IF EXISTS public.sessions_id_seq;
DROP TABLE IF EXISTS public.sessions;
DROP SEQUENCE IF EXISTS public.posts_id_seq;
DROP SEQUENCE IF EXISTS public.posts_hashtag_id_seq;
DROP TABLE IF EXISTS public.posts_hashtag;
DROP TABLE IF EXISTS public.posts;
DROP SEQUENCE IF EXISTS public.likes_id_seq;
DROP TABLE IF EXISTS public.likes;
DROP SCHEMA IF EXISTS public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: likes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.likes (
    id integer NOT NULL,
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: likes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.likes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: likes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.likes_id_seq OWNED BY public.likes.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    link text NOT NULL,
    content text,
    date timestamp without time zone DEFAULT now() NOT NULL,
    likes_count integer DEFAULT 0 NOT NULL,
    title text,
    description text,
    image text
);


--
-- Name: posts_hashtag; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.posts_hashtag (
    id integer NOT NULL,
    posts_id integer NOT NULL,
    hashtags_id integer NOT NULL
);


--
-- Name: posts_hashtag_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.posts_hashtag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: posts_hashtag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.posts_hashtag_id_seq OWNED BY public.posts_hashtag.id;


--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id integer NOT NULL,
    token text NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: trendings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.trendings (
    id integer NOT NULL,
    hashtag text NOT NULL,
    hash_count integer DEFAULT 0 NOT NULL
);


--
-- Name: trendings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.trendings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: trendings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.trendings_id_seq OWNED BY public.trendings.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    photo text NOT NULL,
    password text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: likes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.likes ALTER COLUMN id SET DEFAULT nextval('public.likes_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- Name: posts_hashtag id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts_hashtag ALTER COLUMN id SET DEFAULT nextval('public.posts_hashtag_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: trendings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trendings ALTER COLUMN id SET DEFAULT nextval('public.trendings_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: likes; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.likes VALUES (24, 11, 10, '2023-06-05 03:52:57.240387');
INSERT INTO public.likes VALUES (25, 11, 1, '2023-06-05 03:58:43.674059');
INSERT INTO public.likes VALUES (30, 11, 15, '2023-06-05 04:53:34.734226');


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.posts VALUES (2, 5, 'https://www.google.com/', 'Alguma coisa muito bacana', '2023-05-31 22:29:22.124506', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (3, 6, 'https://roadmap.sh/postgresql-dba', 'checa só que massa', '2023-05-31 22:48:20.018587', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (4, 6, 'https://roadmap.sh/best-practices/api-security', 'que maneiro', '2023-05-31 22:49:58.39333', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (5, 6, 'https://roadmap.sh/best-practices/api-security', 'compartilhem', '2023-05-31 22:50:07.800957', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (6, 6, 'https://roadmap.sh/best-practices/code-review', 'ótima pratica', '2023-05-31 22:50:41.385704', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (7, 6, 'https://roadmap.sh/guides', 'a quem interessar', '2023-05-31 22:51:38.729954', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (8, 6, 'https://www.nationalgeographicbrasil.com/animais/o-que-os-gatos-pensam-sobre-nos-voce-vai-se-surpreender', 'S2', '2023-05-31 22:52:12.330635', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (9, 6, 'https://www.nationalgeographicbrasil.com/historia/2023/05/a-origem-das-sereias-o-que-diz-a-historia', 'vish', '2023-05-31 22:52:34.435389', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (11, 6, 'https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm', 'S2', '2023-05-31 22:56:30.775895', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (12, 6, 'https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm', 'S2', '2023-06-01 01:04:32.366999', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (13, 6, 'https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm', 'S2', '2023-06-01 01:08:33.30997', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (14, 6, '{"url":"https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm","canonical":"https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm","title":"","image":"","author":"","description":"Quem tem gato provavelmente já viu o momento em que o bichano faz um movimento de \"amassar pãozinho\". Isso ocorre quando ele coloca as patas dianteiras em algum lugar e aperta a região abrindo os dedos, como se estivesse massageando o local.Segu","keywords":"","source":"","price":"","priceCurrency":"","availability":"","robots":"index,follow,max-image-preview:large","jsonld":[{"@type":"ItemList","@context":"http://schema.org","numberOfItems":12,"itemListElement":[[{"@type":"ListItem","name":"Com colarinho? Ciência explica se faz sentido mudar jeito de servir cerveja","position":1,"url":"https://www.uol.com.br/tilt/noticias/redacao/2023/05/27/com-ou-sem-colarinho-existe-jeito-certo-de-servir-cerveja.htm"}],[{"@type":"ListItem","name":"De onde vem o sal do mar? Até cidade brasileira sem praia tempera o oceano","position":2,"url":"https://www.uol.com.br/tilt/colunas/pergunta-pro-jokura/2023/05/22/de-onde-vem-o-sal-do-mar-ate-cidade-brasileira-sem-praia-tempera-o-oceano.htm"}],[{"@type":"ListItem","name":"Astro: robozinho da Amazon vigia a casa e brinca de esconde-esconde","position":3,"url":"https://www.uol.com.br/tilt/videos/2023/05/20/astro-robozinho-da-amazon-vigia-a-casa-e-brinca-de-esconde-esconde.htm"}],[{"@type":"ListItem","name":"Caçador de raios: veja 4 flagrantes de relâmpagos e trovões no Brasil","position":4,"url":"https://www.uol.com.br/tilt/videos/2023/05/20/cacador-de-raios-veja-4-flagrantes-de-relampagos-e-trovoes-no-brasil.htm"}],[{"@type":"ListItem","name":"Kennedy Space Center: como é a ''Disney da Nasa''?","position":5,"url":"https://www.uol.com.br/tilt/videos/2023/05/20/kennedy-space-center-como-e-a-disney-da-nasa.htm"}],[{"@type":"ListItem","name":"Quem é o ''menino dos raios'' que ganhou o mundo com foto de ''união elétrica''","position":6,"url":"https://www.uol.com.br/tilt/noticias/redacao/2023/05/13/quem-e-o-menino-dos-raios-que-ganhou-o-mundo-com-foto-de-uniao-eletrica.htm"}],[{"@type":"ListItem","name":"''Disney da Nasa'' reúne foguetes, ônibus espacial e plano de explorar Marte","position":7,"url":"https://www.uol.com.br/tilt/noticias/redacao/2023/05/07/disney-da-nasa-reune-foguete-naves-e-plano-de-conquistar-marte-no-futuro.htm"}],[{"@type":"ListItem","name":"Como air fryer e micro-ondas esquentam a comida sem derreter o aparelho? ","position":8,"url":"https://www.uol.com.br/tilt/colunas/pergunta-pro-jokura/2023/05/04/como-air-fryer-e-micro-ondas-esquentam-a-comida-sem-derreter-o-aparelho.htm"}],[{"@type":"ListItem","name":"Por que a Nasa vai ''trancar'' 4 pessoas em habitat que simula base em Marte","position":9,"url":"https://www.uol.com.br/tilt/noticias/redacao/2023/04/30/por-que-a-nasa-vai-trancar-4-pessoas-em-habitat-que-simula-base-em-marte.htm"}],[{"@type":"ListItem","name":"Cápsulas de café podem ser usadas para fazer ''refil'' para impressora 3D","position":10,"url":"https://www.uol.com.br/tilt/noticias/redacao/2023/04/29/capsulas-de-cafe-podem-ser-usadas-para-fazer-refil-para-impressora-3d.htm"}],[{"@type":"ListItem","name":"Cientistas podem ter decifrado mistério do calendário maia","position":11,"url":"https://www.uol.com.br/tilt/ultimas-noticias/deutschewelle/2023/04/25/cientistas-podem-ter-decifrado-misterio-do-calendario-maia.htm"}],[{"@type":"ListItem","name":"Conexão que vem do espaço: como funciona a internet via satélite?","position":12,"url":"https://www.uol.com.br/tilt/noticias/redacao/2023/04/23/como-e-a-conexao-por-satelite-do-espaco.htm"}]],"url":"https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm","mainEntityOfPage":"https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm","image":{"url":"https://conteudo.imguol.com.br/c/interacao/facebook/uol-tilt-wide.png","width":2960,"height":1163,"@type":"ImageObject"}}],"og:url":"https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm","og:locale":"pt_BR","og:locale:alternate":"","og:title":"Por que os gatos ''amassam pãozinho''? A ciência tem as respostas","og:type":"article","og:description":"Quem tem gato provavelmente já viu o momento em que o bichano faz um movimento de \"amassar pãozinho\". Isso ocorre quando ele coloca as patas dianteiras em algum lugar e aperta a região abrindo os dedos, como se estivesse massageando o local.Segu","og:determiner":"","og:site_name":"","og:image":"https://conteudo.imguol.com.br/c/entretenimento/36/2022/05/22/gata-tricolor-gato-gatos-1653265224214_v2_615x300.jpg","og:image:secure_url":"","og:image:type":"","og:image:width":"615","og:image:height":"300","twitter:title":"Por que os gatos ''amassam pãozinho''? A ciência tem as respostas","twitter:description":"Quem tem gato provavelmente já viu o momento em que o bichano faz um movimento de \"am...","twitter:image":"https://conteudo.imguol.com.br/c/entretenimento/36/2022/05/22/gata-tricolor-gato-gatos-1653265224214_v2_615x300.jpg","twitter:image:alt":"","twitter:card":"summary_large_image","twitter:site":"tiltuol @UOL","twitter:site:id":"","twitter:url":"","twitter:account_id":"","twitter:creator":"","twitter:creator:id":"","twitter:player":"","twitter:player:width":"","twitter:player:height":"","twitter:player:stream":"","twitter:app:name:iphone":"","twitter:app:id:iphone":"","twitter:app:url:iphone":"","twitter:app:name:ipad":"","twitter:app:id:ipad":"","twitter:app:url:ipad":"","twitter:app:name:googleplay":"","twitter:app:id:googleplay":"","twitter:app:url:googleplay":"","responseBody":"","article:published_time":"","article:modified_time":"","article:expiration_time":"","article:author":"","article:section":"","article:tag":"Technology","og:article:published_time":"","og:article:modified_time":"","og:article:expiration_time":"","og:article:author":"","og:article:section":"","og:article:tag":"","fb:pages":"120098554660","referrer":"no-referrer-when-downgrade","viewport":"width=device-width, viewport-fit=cover, initial-scale=1.0, user-scalable=yes, minimum-scale=1.0, maximum-scale=10.0","format-detection":"telephone=no","google-site-verification":"uPoEEmwsmGUXmhtQSbPK1DFcI9TNUZB19rqvpshC4vw","p:domain_verify":"iJ7w3DGFkgB03wl82ITt6M5nRz6orofQfPB1XWpvQ04=","msapplication-tap-highlight":"no","fb:app_id":"190329594333794","og:name":"UOL","article:publisher":"https://www.facebook.com/UOL","article:opinion":"false","ia:rules_url":"https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm?loadComponent=rule-generator&data=%7B%22mediaId%22%3A%226d6c1da6919731db19ebcc4b4a81cd820221213%22%2C%22collection%22%3A%22Curiosidades%20de%20Ci%C3%AAncias%22%2C%22tags%22%3A%2279692%2C13703%2C81965%22%2C%22central%22%3A%22tilt%22%2C%22channel%22%3A%22ciencia%22%2C%22publicationDate%22%3A%2220221213102700%22%2C%22gaAuthor%22%3A%22Rafael%20Souza%3B%22%2C%22heroImage%22%3Atrue%2C%22author%22%3A%7B%22name%22%3A%22Rafael%20Souza%22%2C%22image%22%3Anull%7D%7D","theme-color":"#1a1a1a","msapplication-square310x310logo":"https://conteudo.imguol.com.br/pwa/icons/tilt/tilt-512.png"}', 'S2', '2023-06-01 01:13:12.296522', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (16, 6, 'https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm', 'S2', '2023-06-01 02:38:37.156195', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (17, 6, 'https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm', 'S2', '2023-06-01 02:42:49.736614', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (18, 6, 'https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm', 'S2', '2023-06-01 02:43:25.729355', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (19, 6, 'https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm', 'S2', '2023-06-01 02:52:14.97138', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (20, 11, 'https://example.com', 'Conteúdo do post', '2023-06-01 19:00:37.64199', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (21, 11, 'https://example.com', 'Conteúdo do post', '2023-06-01 19:00:54.67272', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (22, 11, 'https://example.com', 'Conteúdo do post', '2023-06-01 19:03:00.484217', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (23, 11, 'https://example.com', NULL, '2023-06-01 19:03:07.580318', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (24, 11, 'https://example.com', 'Conteúdo do post', '2023-06-01 19:03:31.420859', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (25, 11, 'https://example.com', 'Conteúdo do post', '2023-06-01 19:04:02.551082', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (26, 11, 'https://example.com', 'Conteúdo do post', '2023-06-01 19:05:13.525464', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (27, 11, 'https://example.com', 'Conteúdo do post', '2023-06-01 19:09:19.400997', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (28, 11, 'https://example.com', 'Conteúdo do post', '2023-06-01 19:09:39.996072', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (29, 11, 'https://teste.com', 'Conteúdo do post teste', '2023-06-01 19:20:34.683416', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (30, 11, 'https://teste2.com', 'Conteúdo do post teste2', '2023-06-01 19:21:16.973732', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (31, 11, 'https://teste3.com', 'Conteúdo do post teste3', '2023-06-01 19:23:22.571306', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (32, 11, 'https://teste4.com', 'Conteúdo do post teste4', '2023-06-01 19:31:10.005623', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (33, 11, 'https://teste4.com', 'Conteúdo do post teste4', '2023-06-01 19:31:58.975515', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (34, 11, 'https://teste4.com', 'Conteúdo do post teste4', '2023-06-01 19:32:35.940751', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (35, 11, 'https://teste4.com', 'Conteúdo do post teste4', '2023-06-01 19:32:48.139539', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (36, 11, 'https://teste4.com', 'Conteúdo do post teste4', '2023-06-01 19:34:45.97603', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (37, 11, 'https://teste5.com', 'Conteúdo do post teste5', '2023-06-01 19:40:51.618898', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (38, 11, 'https://teste5.com', 'Conteúdo do post teste5', '2023-06-01 19:45:36.763208', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (39, 11, 'https://teste6.com', 'Conteúdo do post teste6', '2023-06-01 19:57:11.311446', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (40, 12, 'https://github.com/FernandoM52/Linkr-front', 'Testando posts', '2023-06-01 20:34:08.586492', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (41, 12, 'https://github.com/FernandoM52/Linkr-front', 'Testando posts 2', '2023-06-01 20:39:24.216863', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (42, 12, 'https://github.com/FernandoM52/Linkr-front', 'Testando post com função do fernando', '2023-06-01 20:41:48.048098', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (43, 12, 'https://github.com/FernandoM52/Linkr-front', 'Testando post com função do fernando 2', '2023-06-01 20:42:26.064402', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (44, 12, 'https://github.com/FernandoM52/Linkr-front', 'Testando post com função do fernando 3', '2023-06-01 20:45:11.419842', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (45, 12, 'https://github.com/FernandoM52/Linkr-front', 'Testando post com função do fernando 4', '2023-06-01 20:46:19.513369', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (46, 11, 'https://teste6.com', 'Conteúdo do post teste6', '2023-06-01 20:53:26.835186', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (47, 11, 'https://teste6.com', 'Conteúdo do post teste6', '2023-06-01 20:53:59.408991', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (48, 11, 'https://teste6.com', 'Conteúdo do post teste6', '2023-06-01 20:54:32.005362', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (49, 12, 'https://github.com/FernandoM52/Linkr-front', 'Testando post com função do fernando 5', '2023-06-01 21:00:24.660485', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (50, 12, 'https://github.com/FernandoM52/Linkr-front', 'Testando post com função do fernando 5', '2023-06-01 21:01:54.896015', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (51, 12, 'https://github.com/FernandoM52/Linkr-front', 'Testando post com função do fernando 6', '2023-06-01 21:09:53.994904', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (52, 12, 'https://github.com/FernandoM52/Linkr-front', 'Testando post com função do fernando 7', '2023-06-01 21:12:26.103307', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (53, 6, 'https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm', 'S2', '2023-06-01 21:46:56.482875', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (54, 5, 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fcanaldopet.ig.com.br%2Fguia-bichos%2Fgatos%2F2022-04-14%2Fcomo-mudar-o-nome-de-um-gato.html&psig=AOvVaw2rt5_Y2vGwtmsb792oBdYz&ust=1685742539673000&source=images&cd=vfe&ved=0CBMQjhxqFwoTCJDgqryGo_8CFQAAAAAdAAAAABAE', 'testeee', '2023-06-01 21:49:19.355269', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (55, 12, 'https://github.com/FernandoM52/Linkr-front', 'Testando post com função do fernando 8', '2023-06-01 23:30:20.562151', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (56, 12, 'https://github.com/FernandoM52/Linkr-front', 'Testando post com função do fernando 8', '2023-06-01 23:31:55.151532', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (57, 12, 'https://github.com/FernandoM52/Linkr-front', 'Testando post com função do fernando 8', '2023-06-01 23:48:50.232244', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (58, 12, 'https://github.com/FernandoM52/Linkr-front', 'Testando post com função do fernando 9', '2023-06-01 23:51:10.174348', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (59, 12, 'https://github.com/FernandoM52/Linkr-front', 'Testando post com hashtag #JavaScript', '2023-06-01 23:52:37.914728', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (60, 12, 'https://github.com/FernandoM52/Linkr-front', 'Teste post 2 com hashtag #JavaScript', '2023-06-01 23:56:49.851458', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (61, 12, 'https://github.com/FernandoM52/Linkr-front', 'Postando com hashtag #javascript', '2023-06-02 00:04:55.650042', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (62, 12, 'https://github.com/FernandoM52/Linkr-front', 'Postando com hashtag #react', '2023-06-02 00:05:58.70923', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (10, 6, 'https://www.nationalgeographicbrasil.com/animais/2023/05/vinganca-ou-diversao-por-que-as-orcas-estao-atacando-barcos', 'vish', '2023-05-31 22:53:39.765065', 1, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (1, 5, 'https://www.google.com/', 'alguma coisa só pra testar mesmo', '2023-05-31 17:35:12.00834', 1, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (63, 12, 'https://github.com/FernandoM52/Linkr-front', 'Postando 2 com hashtag #react', '2023-06-02 00:06:07.708055', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (64, 12, 'https://github.com/FernandoM52/Linkr-front', 'Postando 2 com hashtag #node', '2023-06-02 00:06:22.25256', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (65, 12, 'https://github.com/FernandoM52/Linkr-back', 'Aparentemente nossa função está dando certo!! #node', '2023-06-02 00:07:03.105372', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (66, 12, 'https://github.com/FernandoM52/Linkr-back', 'Aumentando a hashCount do node hehehe #node', '2023-06-02 00:07:39.874765', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (67, 12, 'https://github.com/FernandoM52/Linkr-back', 'Postando sem hash agora!', '2023-06-02 00:08:51.607562', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (68, 12, 'https://github.com/FernandoM52/Linkr-back', 'Postando sem hash agora! 2', '2023-06-02 00:09:51.868136', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (69, 12, 'https://github.com/FernandoM52/Linkr-back', 'Postando sem hash agora! 3', '2023-06-02 00:15:31.254875', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (70, 12, 'https://github.com/FernandoM52/Linkr-back', 'Postando sem hash agora! 4', '2023-06-02 00:16:56.35154', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (71, 12, 'https://github.com/FernandoM52/Linkr-back', 'Postando sem hash agora! 5', '2023-06-02 00:19:16.539647', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (72, 12, 'https://github.com/FernandoM52/Linkr-back', 'Postando sem hash agora! 6', '2023-06-02 00:22:59.592799', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (73, 12, 'https://github.com/FernandoM52/Linkr-back', 'Postando sem hash agora! 7', '2023-06-02 00:26:11.870884', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (74, 12, 'https://github.com/FernandoM52/Linkr-back', 'Deu certo sem agora!', '2023-06-02 00:26:49.683409', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (75, 12, 'https://github.com/FernandoM52/Linkr-back', 'Testando novametne com hash #node', '2023-06-02 00:27:05.800968', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (76, 12, 'https://github.com/FernandoM52/Linkr-back', 'Deu certo também! #javascript', '2023-06-02 00:27:27.38973', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (77, 12, 'https://github.com/FernandoM52/Linkr-back', 'Criando uma trending #ProjetaoGrupo6', '2023-06-02 00:27:50.438436', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (78, 6, 'https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm', 'gatos amassam pãozinho', '2023-06-02 01:05:48.10313', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (79, 6, 'https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm', 'gatos amassam pãozinho', '2023-06-02 01:06:21.604653', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (80, 6, 'https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm', 'gatos amassam pãozinho', '2023-06-02 01:06:52.31203', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (81, 6, 'https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm', 'gatos amassam pãozinho', '2023-06-02 01:07:21.09733', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (82, 6, 'https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm', 'gatos amassam pãozinho', '2023-06-02 01:26:42.169949', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (92, 6, 'https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm', 'gatos amassam pãozinho', '2023-06-02 02:57:31.552993', 0, NULL, NULL, NULL);
INSERT INTO public.posts VALUES (93, 6, 'https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm', 'gatos amassam pãozinho', '2023-06-02 03:08:59.818046', 0, '', 'Quem tem gato provavelmente já viu o momento em que o bichano faz um movimento de "amassar pãozinho". Isso ocorre quando ele coloca as patas dianteiras em algum lugar e aperta a região abrindo os dedos, como se estivesse massageando o local.Segu', '');
INSERT INTO public.posts VALUES (94, 19, 'https://github.com/FernandoM52/Linkr-back', 'Testando novo post implementado!', '2023-06-02 03:21:18.348097', 0, '', 'Contribute to FernandoM52/Linkr-back development by creating an account on GitHub.', '');
INSERT INTO public.posts VALUES (95, 19, 'https://www.nationalgeographicbrasil.com/', 'verificando valores do post dentro do banco!', '2023-06-02 03:22:47.626396', 0, 'Brasil | National Geographic', '', '');
INSERT INTO public.posts VALUES (96, 19, 'https://br.pinterest.com/pin/2111131068343091/', 'verificando valores das novas colunas do post dentro do banco!', '2023-06-02 03:24:53.653514', 0, '', 'Aug 24, 2021 - This Pin was discovered by Clare Montero. Discover (and save!) your own Pins on Pinterest', '');
INSERT INTO public.posts VALUES (97, 19, 'https://br.pinterest.com/pin/2111131068343091/', 'Testando post com mais de uma hashtag #teste #projetao', '2023-06-02 03:55:41.798517', 0, '', 'Aug 24, 2021 - This Pin was discovered by Clare Montero. Discover (and save!) your own Pins on Pinterest', '');
INSERT INTO public.posts VALUES (98, 19, 'https://br.pinterest.com/pin/2111131068343091/', 'Dando console.log em uma hashtag #javascript', '2023-06-02 17:19:19.510183', 0, '', 'Aug 24, 2021 - This Pin was discovered by Clare Montero. Discover (and save!) your own Pins on Pinterest', '');
INSERT INTO public.posts VALUES (99, 19, 'https://github.com/FernandoM52/Linkr-back', 'Alterando formato de inserção das hashtags no banco #sql', '2023-06-02 17:31:53.948072', 0, '', 'Contribute to FernandoM52/Linkr-back development by creating an account on GitHub.', '');
INSERT INTO public.posts VALUES (100, 19, 'https://github.com/FernandoM52/Linkr-back', 'Testando criação de posts após refatorar controller newPost', '2023-06-02 18:31:29.278391', 0, '', 'Contribute to FernandoM52/Linkr-back development by creating an account on GitHub.', '');
INSERT INTO public.posts VALUES (101, 19, 'https://github.com/FernandoM52/Linkr-back', 'Testando criação de posts após refatorar controller newPost, agora com hashtag #node', '2023-06-02 18:33:45.542452', 0, '', 'Contribute to FernandoM52/Linkr-back development by creating an account on GitHub.', '');
INSERT INTO public.posts VALUES (104, 6, 'https://g1.globo.com/mundo/noticia/2023/06/02/trem-descarrilha-na-india.ghtml', 'gatos amassam pãozinho', '2023-06-03 00:20:10.700346', 0, 'Trem descarrila na Índia e deixa 207 mortos', 'A colisão aconteceu após o trem Coromandel Express bater de frente com um trem de carga, disseram autoridades locais', 'https://s2-g1.glbimg.com/AhiHmvIZrRe29Fi0G-47BEmLvK8=/1200x/smart/filters:cover():strip_icc()/s03.video.glbimg.com/x720/11669786.jpg');
INSERT INTO public.posts VALUES (105, 6, 'https://g1.globo.com/mundo/noticia/2023/06/02/trem-descarrilha-na-india.ghtml', 'gatos amassam pãozinho', '2023-06-03 02:17:42.646312', 0, 'Trem descarrila na Índia e deixa 233 mortos', 'A colisão aconteceu após o trem Coromandel Express bater de frente com um trem de carga, disseram autoridades locais', 'https://s2-g1.glbimg.com/AhiHmvIZrRe29Fi0G-47BEmLvK8=/1200x/smart/filters:cover():strip_icc()/s03.video.glbimg.com/x720/11669786.jpg');
INSERT INTO public.posts VALUES (15, 6, 'https://www.uol.com.br/tilt/noticias/redacao/2022/12/13/por-que-os-gatos-amassam-paozinho-a-ciencia-tem-uma-resposta-curiosa.htm', 'S2', '2023-06-01 01:22:32.10386', 1, NULL, NULL, NULL);


--
-- Data for Name: posts_hashtag; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.posts_hashtag VALUES (1, 61, 1);
INSERT INTO public.posts_hashtag VALUES (2, 62, 2);
INSERT INTO public.posts_hashtag VALUES (3, 63, 2);
INSERT INTO public.posts_hashtag VALUES (4, 64, 9);
INSERT INTO public.posts_hashtag VALUES (5, 65, 9);
INSERT INTO public.posts_hashtag VALUES (6, 66, 9);
INSERT INTO public.posts_hashtag VALUES (7, 75, 9);
INSERT INTO public.posts_hashtag VALUES (8, 76, 1);
INSERT INTO public.posts_hashtag VALUES (9, 77, 11);
INSERT INTO public.posts_hashtag VALUES (10, 97, 12);
INSERT INTO public.posts_hashtag VALUES (11, 97, 13);
INSERT INTO public.posts_hashtag VALUES (12, 98, 1);
INSERT INTO public.posts_hashtag VALUES (13, 99, 10);
INSERT INTO public.posts_hashtag VALUES (14, 101, 9);


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.sessions VALUES (1, 'f47d5eeb-7e52-4f40-b2d7-e16b65afe8bc', 1, '2023-05-31 04:05:18.188546');
INSERT INTO public.sessions VALUES (2, '7a302e05-31a2-4515-85eb-48ec0b070c69', 2, '2023-05-31 04:06:35.723842');
INSERT INTO public.sessions VALUES (3, '8e823270-5fc9-43b7-b8e5-50353d2fa74d', 3, '2023-05-31 04:13:35.74894');
INSERT INTO public.sessions VALUES (4, 'b34f5a37-db3e-48ca-a381-3cff9c991bb1', 4, '2023-05-31 04:16:16.908324');
INSERT INTO public.sessions VALUES (6, 'cbce4fd6-899a-467f-a197-8399da370fb2', 6, '2023-05-31 22:45:46.348012');
INSERT INTO public.sessions VALUES (7, '302f9c02-35f5-4886-8460-7ea0f7809c53', 9, '2023-06-01 18:34:23.025885');
INSERT INTO public.sessions VALUES (8, 'b6bb5ee8-2c0e-432e-b987-6cc3a52cd8f4', 10, '2023-06-01 18:49:46.825545');
INSERT INTO public.sessions VALUES (82, 'b826083b-17a3-47aa-9b53-b982bcce04aa', 11, '2023-06-05 05:29:27.562259');
INSERT INTO public.sessions VALUES (86, 'a9e3e997-674b-427d-80bf-fcfe9cd80d45', 12, '2023-06-05 20:57:02.692319');
INSERT INTO public.sessions VALUES (31, '7ee0a700-95ee-4841-a68b-c6a34a53b919', 19, '2023-06-02 03:20:38.622648');
INSERT INTO public.sessions VALUES (42, '0dd95b1f-7cc4-4b53-8afd-a1498b2f1052', 5, '2023-06-02 21:09:04.043702');


--
-- Data for Name: trendings; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.trendings VALUES (3, 'react-native', 0);
INSERT INTO public.trendings VALUES (4, 'material', 0);
INSERT INTO public.trendings VALUES (5, 'web-dev', 0);
INSERT INTO public.trendings VALUES (6, 'mobile', 0);
INSERT INTO public.trendings VALUES (7, 'css', 0);
INSERT INTO public.trendings VALUES (8, 'html', 0);
INSERT INTO public.trendings VALUES (2, 'react', 2);
INSERT INTO public.trendings VALUES (11, 'ProjetaoGrupo6', 1);
INSERT INTO public.trendings VALUES (12, 'teste', 1);
INSERT INTO public.trendings VALUES (13, 'projetao', 1);
INSERT INTO public.trendings VALUES (1, 'javascript', 3);
INSERT INTO public.trendings VALUES (10, 'sql', 1);
INSERT INTO public.trendings VALUES (9, 'node', 5);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users VALUES (1, 'Nome do usuário', 'email@example.com', 'https://example.com/photo.jpg', '$2b$10$gwD2hvhFPFfJQ6HemVcMPuY1coo/ZFGneWd9VHFoOTuisSNkmpMtu', '2023-05-31 04:04:05.918073');
INSERT INTO public.users VALUES (2, 'Teste', 'teste@example.com', 'https://example.com/photo.jpg', '$2b$10$ODtFtmkXm6yST3cCT4jnM.y0qkcxzvwLOeZ9HN6UcMGwx/T0fW10u', '2023-05-31 04:06:18.585363');
INSERT INTO public.users VALUES (3, 'Teste 2', 'teste2@example.com', 'https://example.com/photo.jpg', '$2b$10$U1dz6jjKOMoKZWJ7YItWo.yPRokUSvE24Falfv4QAvXR/CbCRLpMu', '2023-05-31 04:13:07.619495');
INSERT INTO public.users VALUES (4, 'Teste 3', 'teste3@example.com', 'https://example.com/photo.jpg', '$2b$10$f2SwEPBYZpzAUPQmIWQ0b./JuupSOQOWVe8YKRlqAAro26aWPSSGy', '2023-05-31 04:16:04.408154');
INSERT INTO public.users VALUES (5, 'João Bosco', 'joao@teste.com', 'https://i.redd.it/rs7fr2ymh39a1.png', '$2b$10$n1dZuRtFA0hnDxyXCVNcrO4bxOcn1wQErginAzejhMg/.aULgVtUe', '2023-05-31 17:23:55.097581');
INSERT INTO public.users VALUES (6, 'let', 'let@let.com', 'https://static.nationalgeographicbrasil.com/files/styles/image_3200/public/75552.webp?w=1600&h=900', '$2b$10$OOUplumN.bFA3Q0eUY6tX.XfRXR9BlOEZ4XFCn/ODUDTkCYUUYwYG', '2023-05-31 22:44:16.34819');
INSERT INTO public.users VALUES (7, 'Eve', 'eve@example.com', 'https://conteudo.imguol.com.br/blogs/48/files/2016/09/gata3.jpg', '$2b$10$s7cy1/lUu2WSfet4e.oc/uWDgcZpPOX5e15ERuvevnn.VrZRR7PEe', '2023-06-01 15:42:01.277177');
INSERT INTO public.users VALUES (8, 'Eve teste 2', 'eve2@example.com', 'https://conteudo.imguol.com.br/blogs/48/files/2016/09/gata3.jpg', '$2b$10$IiZ.FJE0zvV32/03n8lRpuu0eWfzUOtihulJb9l5J/9W8dKSJmAaO', '2023-06-01 15:46:59.434707');
INSERT INTO public.users VALUES (9, 'Eve teste 3', 'eve3@example.com', 'https://conteudo.imguol.com.br/blogs/48/files/2016/09/gata3.jpg', '$2b$10$ne.cilY4sRs8CaLRW.aBsOtBJhnZEY1EDxTVxSpVI9qdAx/k5nAXC', '2023-06-01 18:33:21.65335');
INSERT INTO public.users VALUES (10, 'Eve teste 4', 'eve4@example.com', 'https://conteudo.imguol.com.br/blogs/48/files/2016/09/gata3.jpg', '$2b$10$3M0ahy7sf.UBpCMTVRnMEu1/7k79UYtbIprO/GTTli4wmAvR8FEtm', '2023-06-01 18:49:31.190986');
INSERT INTO public.users VALUES (11, 'Eve teste 5', 'eve5@example.com', 'https://conteudo.imguol.com.br/blogs/48/files/2016/09/gata3.jpg', '$2b$10$mQqy63oWffWu649HWb.sh.mEK3sDMWYVtTYnbcDbi4B3s0NHxZGNu', '2023-06-01 18:51:11.386993');
INSERT INTO public.users VALUES (12, 'Fernando Martins', 'fernando@fernando.com', 'https://static.tudointeressante.com.br/uploads/2014/11/gato-17.jpg', '$2b$10$f4BUTgSccb43Jb//vVuSLOOPmnlQmu4HXA.5M0WKW018c2VDjkEni', '2023-06-01 20:22:34.489283');
INSERT INTO public.users VALUES (13, 'Fernando Martins', 'fernando2@fernando.com', 'https://static.tudointeressante.com.br/uploads/2014/11/gato-17.jpg', '$2b$10$QTEwrcx1T7PbZPXO7bhQU.BgDX2GQdzLK3Kd/IgS6lPU8t9w1udva', '2023-06-01 20:24:42.406439');
INSERT INTO public.users VALUES (14, 'Teste com import da url-metadata', 'fernando3@fernando.com', 'https://static.tudointeressante.com.br/uploads/2014/11/gato-17.jpg', '$2b$10$9J8g/MNVE8wMuRBXn1dwreRVXzyOCE/thaQUwtmJxH7YvLZWAJ05u', '2023-06-01 20:27:12.038821');
INSERT INTO public.users VALUES (15, 'Teste 2 com import da url-metadata', 'fernando4@fernando.com', 'https://static.tudointeressante.com.br/uploads/2014/11/gato-17.jpg', '$2b$10$7PK1lppe9N9aA2gLA.SInO/GfBBHTKekHcERRDIUlFVYeyqvpOv96', '2023-06-01 20:27:40.857547');
INSERT INTO public.users VALUES (16, 'Teste com função do fernando', 'fernando5@fernando.com', 'https://static.tudointeressante.com.br/uploads/2014/11/gato-17.jpg', '$2b$10$VeymAnieOGVQFcZlYcu.7e1m0W/RrF1XkR62P2DV2tE8GyJ2AXkBy', '2023-06-01 20:39:57.061721');
INSERT INTO public.users VALUES (17, 'aaa', 'aaa@aaa.com', 'https://www.petz.com.br/blog/wp-content/uploads/2022/02/gato-e-carnivoro2.jpg', '$2b$10$Ay9jFaGZJk5qY.SyFbsx3OiyT4Gd6iPwX7OZ/xZlsN67yykCgrbua', '2023-06-02 02:01:04.792692');
INSERT INTO public.users VALUES (18, 'teste', 'teste@teste.com', 'https://www.petz.com.br/blog/wp-content/uploads/2022/02/gato-e-carnivoro2.jpg', '$2b$10$463LeQOctq3Xz2TmKQKAqewKoXFOZBb/gVoQCm6TAEsGz.FJlhgzO', '2023-06-02 02:02:55.672102');
INSERT INTO public.users VALUES (19, 'Testando rotas com novo commit', 'fernando6@fernando.com', 'https://static.tudointeressante.com.br/uploads/2014/11/gato-17.jpg', '$2b$10$5VkHoyZ96xJUn6X9Vi8xq.9S7Cg7FTHFGgCaZrfdxW/qOZzLhC92y', '2023-06-02 03:20:25.09104');
INSERT INTO public.users VALUES (20, 'Eve teste 6', 'eve6@example.com', 'https://conteudo.imguol.com.br/blogs/48/files/2016/09/gata3.jpg', '$2b$10$jcYv3unHDRw9aIKseOiOQeyKHAgqF2pZ8k.2KM25tY8HCIfP6O.GS', '2023-06-02 15:04:00.072062');
INSERT INTO public.users VALUES (21, 'testando cadastro', 'testandocadastro@fernando.com', 'https://i.pinimg.com/originals/32/a2/f5/32a2f5eba9634a98784b1a94392c2da0.jpg', '$2b$10$4xCLuXZpnOVr.2chDpaQ8uPvfFPrHlWiycluJJlMakIZocQkvQ9uq', '2023-06-02 18:54:03.473565');
INSERT INTO public.users VALUES (22, 'Eve teste 7', 'eve7@example.com', 'https://conteudo.imguol.com.br/blogs/48/files/2016/09/gata3.jpg', '$2b$10$z6ktu4mCvch8yp05muO8NeOpLA4z.OYcgjwbK7gC83cQYJifpl6gy', '2023-06-03 22:24:33.478612');
INSERT INTO public.users VALUES (23, 'teste amém', 'teste10@teste.com', 'data:image/jpeg;base64,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', '$2b$10$tUGG1CgJi7rHCJ5AMMN6puf7dl04Oir8AdIQ/tnXm.QzU5PuO9BUq', '2023-06-03 23:08:13.605874');
INSERT INTO public.users VALUES (24, 'aaa2', 'aaa15@aaa.com', 'data:image/jpeg;base64,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', '$2b$10$B2aH.E8mHejYfrs.0X7tquR21gZkq.PRoR/NPtGhlxN4ZnMkPOrJG', '2023-06-04 15:19:28.806668');


--
-- Name: likes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.likes_id_seq', 30, true);


--
-- Name: posts_hashtag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.posts_hashtag_id_seq', 14, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.posts_id_seq', 105, true);


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sessions_id_seq', 86, true);


--
-- Name: trendings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.trendings_id_seq', 13, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 24, true);


--
-- Name: likes likes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_pkey PRIMARY KEY (id);


--
-- Name: posts_hashtag posts_hashtag_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts_hashtag
    ADD CONSTRAINT posts_hashtag_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_token_key UNIQUE (token);


--
-- Name: trendings trendings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trendings
    ADD CONSTRAINT trendings_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: likes likes_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id);


--
-- Name: likes likes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: posts_hashtag posts_hashtag_hashtags_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts_hashtag
    ADD CONSTRAINT posts_hashtag_hashtags_id_fkey FOREIGN KEY (hashtags_id) REFERENCES public.trendings(id);


--
-- Name: posts_hashtag posts_hashtag_posts_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts_hashtag
    ADD CONSTRAINT posts_hashtag_posts_id_fkey FOREIGN KEY (posts_id) REFERENCES public.posts(id);


--
-- Name: posts posts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

