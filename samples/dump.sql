--
-- PostgreSQL database dump
--

-- Dumped from database version 10.7
-- Dumped by pg_dump version 10.11

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

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: passwords; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.passwords (
    plain character varying NOT NULL,
    hash character varying NOT NULL,
    decrypt character varying,
    id integer NOT NULL
);


ALTER TABLE public.passwords OWNER TO postgres;

--
-- Name: passwords_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.passwords_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.passwords_id_seq OWNER TO postgres;

--
-- Name: passwords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.passwords_id_seq OWNED BY public.passwords.id;


--
-- Name: passwords id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passwords ALTER COLUMN id SET DEFAULT nextval('public.passwords_id_seq'::regclass);


--
-- Data for Name: passwords; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.passwords (plain, hash, decrypt, id) FROM stdin;
cxgu	665b3969a1fdd0447acf7f21354f15ba53cb7f6f43086b9758aee661c7d23df0	\N	50
oyuo	3e8b625b52d562c9694ba2bcb429412835488909d0fead83a85ab5597d6c4855	\N	51
nwcl	38598ad5f766959be6a1f24ce1e6a591853bb2082e42914d230673d5cc75f052	\N	34
gzxd	e139a8f56f161268b9f6a855df8027287bb1b4225a92b4f5958f105c4473a6ba	\N	35
heal	599f8341fe3e0fd23de7d89500b8224965ab536307049a175bcd30331d0918c5	\N	36
fija	9e03ef28a3ad312d4373797b86326249365bb90dc590fc1753df642ffd7e81de	\N	37
wnmz	ae82e5f2787d04df9ab5e4db83ec3d1740f8a770f9a661768e4c33abcd1c5f06	\N	38
ftrf	714d8ee7e7f9da32b9082ee1c840b558a07e42aa7b390b9117e68b7ea8d338c4	\N	60
ojqz	96abf4c04969af4e4c0f01a43d2e9cbcccfa5d3cb1d2b3e88ff010deadcadf23	\N	56
esro	d99c1bfbb25863ae540f5800e61bb242654fe7f85c75079ea9d61b0320ec00c3	\N	57
igud	c6a19473f3d414aa8d71579ed0200db243bf1139622a16f69b24be88a29fc0ef	\N	39
piaj	cccb647868bc1978be397438a88a1354b1e3d22b3de07fd8ecbeb21f33bd1aea	\N	61
xdmc	637f1e4784fdb6801fdc5845d9c07060b5470e9de7218bb3883229125be60b7f	\N	42
xoif	c1900ab74b70075811535982ff827dd35e17fbb3880ed1fb06b19436a946dd4a	\N	43
swon	62dfa2bb4d229b5dca061b073c5669b6e8750a2ddcf96f1bb2bae2e02ae32575	\N	48
thzy	587dbef353435e2b9ea984c1914add3eea585d02250eb6246df0122ef8235024	\N	52
mypu	25f8a2b2afc0e24cf834eab2b93f2d8ab72d31fe51a3bca727308e901c7141ac	\N	49
pkqp	1562009ad974bcf4597bb25a31eea9b1e3ce57ee75e3b9a7364e2a2468e840f6	\N	62
ccin	7bc0e5503b4481b595a2a4deb5e458c587f75472a2bd30188dbfb568b38b685d	\N	63
brqz	c7df339272655607809b9614b94e7e40844016646c302f3e401d5d0a1ab9b7c3	\N	76
wivq	e76e0197d86a4e094629aa34785fc7cbb20cad9665a8a8a928c8064771e20457	\N	77
axux	264e6452ad9613321766b051fd52d015b7a1c335d19c07dae3aef6bdfb4f9460	\N	53
divo	f5c7b08b78090d036d83baf83708c12e77a8ee7df9bf132f467b8d50b3d6b945	\N	58
bizp	e5c369980b99334a6a3da801cf71d6dedb7fee09da335e2d698fbd063d944a99	\N	79
qvao	b93358593157e6fbd0f0c2ccb1a4a3ce31d1f1728ee426f5893f9b38efd6f15a	\N	75
zftn	5a0b9b37ea05da97fda06a24c9a3216b7ab04cf56513f9bf591974121ae838ac	\N	54
fltm	69a2d04242e0a7fcda8a9e36e6ea97d28e11d06f8cd5b51aec25443813da3d25	\N	59
jafs	f3f503bca45f673987dd41223e59b732c6f63493a91047a0bc5f282b1884bb28	\N	70
hncf	f64257429d6fe8cdc5c8a9b56109ad0bbd6ab6cf5dd9b29c89b2d1987f45e31b	\N	71
axrg	a00730ea2ee4e72769484a0734bfa5622a9657a3783beb2b1c352133d36a98e2	\N	55
lnfs	56eb94c282e860d5ed4ff191ffc43475bb36830bb3f8c91c37192bfca1e80eb2	\N	72
lduw	066a3e7eafbec10e4359f3560d022ef28ee94783b756823793fb2409ebabe027	\N	73
bttc	8849bd8bd64bb2be0255c0537c140eb644ccf278d729cc5f5627ee8234a05b97	\N	104
afao	99c5cb5eb9b854779d84218a774a8dc0ed428bb0447862dcbd4e5a4a1af82f98	\N	98
tbpb	2134a745b1af1b12c153b6ac0dd2c62e6fefe1cc851271e4a8efc4ed7f733ed6	\N	107
tqvo	c529fcfd509eaafbc61eda2733793204dc452cb9adf9dafcdf552f6ca6c943e2	\N	100
kcpn	1910d1d836f83f19a9012174895a699fb4e867301f80dbd1e6dc57ee8b802d2f	\N	101
xfma	04c2102d7db7e916cbacfa2cd1174e008580d2706d62b998dc2f656cfd1edfca	\N	108
ekca	aec36f43b01ce7c89c18b38a175e2ee8edefbc5f38e13c5c059c67878d4a35fb	\N	92
tarp	83bbdb1a1b1819f44e8f26c33cff44566b7668ee1a0f81e4c9cffb46b1ca539c	\N	44
ebpc	fde5e803ade2ff30f8beb7e6d9bcf5943edffa5b0d4b6c7533f6a7a2412c180e	\N	45
motm	f00cacf19b36c6a1d208dd69a7901e8108c3e8657b6961169d494daea4780eaf	\N	46
cpkl	b3e4600f1fa4ea5b0a5f788db7dae2c4d5a3ee3da0f500b001067a44a07dda63	\N	47
tlum	ceaae24ca0e51a773dad82d528b9d1662159a41a936fe61773c3d780b7a00713	\N	78
sxfo	0814cae2f854033596e9dbc6d06891bfd9e5f0b0b8407d71cd2a039629cb5088	\N	74
ecbr	4e0277602f5cecf7525553aaca812bc4d39af8539f93c34b0552834d46abf515	\N	86
omnx	d5d19d58f6d652707c8d5fbed5371ee76a78feb3825c21c51823a6b97564ef9f	\N	87
adnv	ccfe05918d3ca051212fad0b3d9b2dde182a7456570eea267e5362157faf8b4e	\N	88
gian	1dd060fb034399fe06e0fdf62a13de2eb3065f5da931fa7b58bd3faf4f15e87f	\N	89
eohc	f7f4cecced1ca364a805c3dcc51d13ae3afcddfb1fdbd3a7650562315274afff	\N	106
zjym	504818991a7c41345fa6b28469fa67c780dab9146ef3bfc0a4ffaa50c8a009e3	\N	96
fmze	0b7281f804fc1ebf2c4b6d4a59c30cc71241db688e663f45c5465ad8d8fbcee6	\N	102
hepr	37397be7c336f4c8469427ab6433f958e9ea4d571746bb1f7e05d6bae253b1b3	\N	97
lrog	818a59eb3d69db68fc4fd3d85db42a436f14a27fd6b1b1e0919c61668a5b968d	\N	114
cjrn	19d144977c7b924a512315fa466d53cd8d5b762de1fb0fb8a94220de48364eef	\N	115
rxsj	ea3f55fed26807ebf394fa517b61665838b4f7b322a42defd25476a21bf1f8b6	\N	116
qyai	b0d6a981049882279650400443b7c9063a7d990b4646391ba9a984e7834a25fa	\N	64
cldp	9a3cf57db7772362a497f2245859bbf58640bbdbfdb2351f8ad2bf594239c1b6	\N	65
wgeo	951c436ae4207dc856cda2b75028d002de9196f9f2cac5bf1406ae7e07221d7c	\N	68
njsm	d5f08ca4a6f80a4e7eddd7cfcb81dec0b16d265f4c20f4b8e935b06b7dcb865f	\N	69
ndre	6e2408b10c24d7411e01a28b2f333a600eff1078b8cfac7c8ba7d0d6615a6224	\N	66
wxmw	c9bc56cc3f9c1f93f7c5fef5a8cab80b9958330cabe45c31aa8d390d335924d1	\N	82
urwf	a942e91f0f6ade01ddd184c5bce1e582f4720791818ae08ec2eb7329c9d58996	\N	81
vtwk	dbb74bb18599efa75d896911da3d7d423bd2f09dad6a22ec734a72c031f54147	\N	67
znxl	fcf75e7778f964172a39faa0c7aab9714734c51a9cd815a12b4bb40212aad1b2	\N	83
sxpq	2377d8b0aaedb9e1fb1ff6d305205bcbee93b60a0eafb208e613c0fa721c602d	\N	84
tbua	887ca276546bddfab7a75b018a20d34458cdd1fb13d6bd30de9597a0131ad80c	\N	85
qyve	31fa60c4e39588c0cfb31f23eae29d94649bfa776d22748c9b560cc40cfea4c4	\N	40
qxub	43e473a6432f6f963fdf0d8ff0b03fc9a666d4bc43c03d9cb1d45189603555f7	\N	41
zqve	873d31707a9afc9a6b8bb5b3a779989677999f00046f54cc64e12e095e9d61c7	\N	90
vxmt	36555fc15803a01738ab8e9a9fc79853aba0cb5146fa3cbaf8ca5515f5f73f82	\N	91
wfwt	d6e4397404ee4e3cb2a5617cd4d0ff1f6e4bf2c73d59be966fa101260637defc	\N	129
mpgs	4f160deee3485e73feaebc589167e3f8a801a9c2bd2196e95255e608cd02e4d7	\N	130
jmre	249783fe2e195d8116f49b99c19ea9d14bb705f72a5e20fc048af414eaa0804f	\N	131
ipgo	fc84c007b8a6fd3a7ce5ea984671c1d350f7b9bff4f3f33a14bf5e14605bd53b	\N	132
rued	05bd6a76fe7fc86e1f9639a38dc83e132c87e13f37f969c74787c9509febae42	\N	133
ress	5ffbc0d4928b527c5e73b3b63c8aa7e6f8bb5240cdb8d63810d5265950e218d1	\N	112
hkjl	fd9ec292a2dc1433866ae2cd7814bc3be35b9450e69cefb066eed16e503b7d6e	\N	113
zgbs	7d53d3f0e177c2e166990582e6e55e3717854cdb56f778fc5ca97f438fe14aa7	\N	120
mttw	68f1b544782c39aea2f9b275bf58dd382762802d70de8bbfc6d3caf5ae857c92	\N	99
uras	384619bfad83c614d0b69962cc89ee5c48903761724e7b8355f319c98579139b	\N	109
jdvs	a0fa2fa0b45798053d77bb30bd260e297ddcba5baf52f10d9646cfc0f28cfd3c	\N	110
bkzs	b901d476d3a7c80bc6c663dbb1a8baceefb55ee1c16b83248cef93491a5fbe53	\N	94
gudl	8d329ef68df6bad5bd48d96414c6060009be2c83695a5bf00634a89a70251f49	\N	111
qqvh	7403272f534bd1c6f4f8b8de5ddb30b51582555ceef37f2d1960927842ff81fb	\N	95
gosk	42f957f7fccf24953607c6d2fcf819c5b1ce556a23191a7dd0474679197ce0fb	\N	80
rirl	0be09d922ba621bc37ee67ba280a6f011a0576cae05656c9fc8d1ef5ec976576	\N	118
foez	393f57a0f771e73e32b9847abf360b97a13d34da3f5c56df4010e9a79d03d8a1	\N	119
byty	7067c61b6a8e2ee8376ffc25b4df573ecd8d4978f2f0b6b20cd0266d46dcbd58	\N	126
zncm	59f156d7158edabd90bd7fa0595186a15d3e09374493b7595e2b8a4989ed08c2	\N	124
olxj	5f7ceb1062fcea01b0ab4b3adc5517a333694643e1c97bd355a98a4692d9833d	\N	125
wvzr	3aa88fbcba06bac93ad72e95e4a8f01005600e3c37a20dc186678f9febbc277a	\N	127
wuzy	be639df6d6df21cce72cc9311ef09704c35042714f949f71d6715dd19c90c527	\N	128
fvfd	a93aefab5169eef7c46feaf7dd08a19a50cbf5b6b2d0d98b375f45afaf635dd4	\N	121
jpnp	115dfceb19f2bb112e69caf8243925845412567198f65eea68b8b1fa7d82790b	\N	122
bjih	cf08cd43cfbb5ff862c1155187fd19feadd3e5354d0684672b73d2dc7f72b39c	\N	123
aokm	1410e38c2ad69b3631536c64f5b8b13a120f5131aa4a6c3fe0dfbad623a22ace	\N	105
stqa	a51031112f7a64256d20c8cd777e15b778bdbb72ac93b37734fbc11d20d7da3b	\N	117
izkv	84b37d1056ee4c7cca8bf451fe57178814aad4a96f6b54a70473238cc54654ee	\N	93
ozjc	642325de1d7005c6ed787edcf0ee02aa5ecedfa390e7d7f0777ed871aafe4f95	\N	103
\.


--
-- Name: passwords_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.passwords_id_seq', 165, true);


--
-- Name: passwords passwords_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passwords
    ADD CONSTRAINT passwords_pk PRIMARY KEY (id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM rdsadmin;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

