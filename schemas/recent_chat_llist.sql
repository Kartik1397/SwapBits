-- Table: public.recent_chat_list

-- DROP TABLE public.recent_chat_list;

CREATE TABLE public.recent_chat_list
(
    id integer NOT NULL DEFAULT nextval('recent_chat_list_id_seq'::regclass),
    user_id integer NOT NULL,
    friend_id integer NOT NULL,
    last_modified timestamp without time zone NOT NULL,
    CONSTRAINT recent_chat_list_pkey PRIMARY KEY (id),
    CONSTRAINT recent_chat_list_friend_id_fkey FOREIGN KEY (friend_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT recent_chat_list_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE public.recent_chat_list
    OWNER to postgres;
-- Index: recent_chat_list_friend_id

-- DROP INDEX public.recent_chat_list_friend_id;

CREATE INDEX recent_chat_list_friend_id
    ON public.recent_chat_list USING btree
    (friend_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: recent_chat_list_last_modified

-- DROP INDEX public.recent_chat_list_last_modified;

CREATE INDEX recent_chat_list_last_modified
    ON public.recent_chat_list USING btree
    (last_modified ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: recent_chat_list_user_id

-- DROP INDEX public.recent_chat_list_user_id;

CREATE INDEX recent_chat_list_user_id
    ON public.recent_chat_list USING btree
    (user_id ASC NULLS LAST)
    TABLESPACE pg_default;