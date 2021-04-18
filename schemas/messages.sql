-- Table: public.messages

-- DROP TABLE public.messages;

CREATE TABLE public.messages
(
    id integer NOT NULL DEFAULT nextval('messages_id_seq'::regclass),
    sender_id integer NOT NULL,
    receiver_id integer NOT NULL,
    message character varying COLLATE pg_catalog."default" NOT NULL,
    "time" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    type character varying COLLATE pg_catalog."default" NOT NULL,
    url character varying COLLATE pg_catalog."default",
    CONSTRAINT messages_pkey PRIMARY KEY (id),
    CONSTRAINT messages_receiver_id_fkey FOREIGN KEY (receiver_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT messages_sender_id_fkey FOREIGN KEY (sender_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE public.messages
    OWNER to postgres;
-- Index: messages_receiver_id

-- DROP INDEX public.messages_receiver_id;

CREATE INDEX messages_receiver_id
    ON public.messages USING btree
    (receiver_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: messages_sender_id

-- DROP INDEX public.messages_sender_id;

CREATE INDEX messages_sender_id
    ON public.messages USING btree
    (sender_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: messages_time

-- DROP INDEX public.messages_time;

CREATE INDEX messages_time
    ON public.messages USING btree
    ("time" ASC NULLS LAST)
    TABLESPACE pg_default;