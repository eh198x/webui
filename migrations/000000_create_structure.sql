
CREATE ROLE test_webui WITH LOGIN PASSWORD 'webui';
GRANT ALL PRIVILEGES ON DATABASE webuidb TO test_webui;


CREATE SCHEMA webui;

CREATE TABLE webui.snippets (
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY (INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1),
    title character varying(100) COLLATE pg_catalog."default" NOT NULL,
    content text COLLATE pg_catalog."default" NOT NULL,
    created timestamp with time zone NOT NULL,
    expires timestamp with time zone NOT NULL
);

CREATE TABLE webui.snippets (
id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
title character varying(100) COLLATE pg_catalog."default" NOT NULL,
content text COLLATE pg_catalog."default" NOT NULL,
created timestamp with time zone NOT NULL,
expires timestamp with time zone NOT NULL
);

CREATE INDEX idx_snippets_created ON webui.snippets(created);

CREATE TABLE webui.users (
id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
name character varying(255) COLLATE pg_catalog."default" NOT NULL,
email character varying(255) COLLATE pg_catalog."default" NOT NULL,
hashed_password CHAR(60) NOT NULL,
created timestamp with time zone NOT NULL,
active boolean NOT NULL DEFAULT true
);

ALTER TABLE webui.users ADD CONSTRAINT users_uc_email UNIQUE (email);


INSERT INTO webui.users (name, email, hashed_password, created) VALUES (
'Alice Jones',
'alice@example.com',
'$2a$12$NuTjWXm3KKntReFwyBVHyuf/to.HEwTy.eS206TNfkGfr6HzGJSWG',
'2018-12-23 17:25:22'
);

INSERT INTO webui.snippets (title, content, created, expires) 
VALUES ('First topic', 'First content', NOW(), NOW() + INTERVAL '12 months');
