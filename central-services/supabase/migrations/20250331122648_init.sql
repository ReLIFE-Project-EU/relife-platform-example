create table "public"."private_table" (
    "id" bigint generated by default as identity not null,
    "created_at" timestamp with time zone not null default now (),
    "name" text not null
);

alter table
    "public"."private_table" enable row level security;

create table "public"."report_requests" (
    "id" bigint generated by default as identity not null,
    "created_at" timestamp with time zone not null default now (),
    "user_id" uuid not null default auth.uid (),
    "description" text,
    "result" json
);

alter table
    "public"."report_requests" enable row level security;

CREATE UNIQUE INDEX private_table_pkey ON public.private_table USING btree (id);

CREATE UNIQUE INDEX report_requests_pkey ON public.report_requests USING btree (id);

alter table
    "public"."private_table"
add
    constraint "private_table_pkey" PRIMARY KEY using index "private_table_pkey";

alter table
    "public"."report_requests"
add
    constraint "report_requests_pkey" PRIMARY KEY using index "report_requests_pkey";

grant delete on table "public"."private_table" to "anon";

grant
insert
    on table "public"."private_table" to "anon";

grant references on table "public"."private_table" to "anon";

grant
select
    on table "public"."private_table" to "anon";

grant trigger on table "public"."private_table" to "anon";

grant truncate on table "public"."private_table" to "anon";

grant
update
    on table "public"."private_table" to "anon";

grant delete on table "public"."private_table" to "authenticated";

grant
insert
    on table "public"."private_table" to "authenticated";

grant references on table "public"."private_table" to "authenticated";

grant
select
    on table "public"."private_table" to "authenticated";

grant trigger on table "public"."private_table" to "authenticated";

grant truncate on table "public"."private_table" to "authenticated";

grant
update
    on table "public"."private_table" to "authenticated";

grant delete on table "public"."private_table" to "postgres";

grant
insert
    on table "public"."private_table" to "postgres";

grant references on table "public"."private_table" to "postgres";

grant
select
    on table "public"."private_table" to "postgres";

grant trigger on table "public"."private_table" to "postgres";

grant truncate on table "public"."private_table" to "postgres";

grant
update
    on table "public"."private_table" to "postgres";

grant delete on table "public"."private_table" to "service_role";

grant
insert
    on table "public"."private_table" to "service_role";

grant references on table "public"."private_table" to "service_role";

grant
select
    on table "public"."private_table" to "service_role";

grant trigger on table "public"."private_table" to "service_role";

grant truncate on table "public"."private_table" to "service_role";

grant
update
    on table "public"."private_table" to "service_role";

grant delete on table "public"."report_requests" to "anon";

grant
insert
    on table "public"."report_requests" to "anon";

grant references on table "public"."report_requests" to "anon";

grant
select
    on table "public"."report_requests" to "anon";

grant trigger on table "public"."report_requests" to "anon";

grant truncate on table "public"."report_requests" to "anon";

grant
update
    on table "public"."report_requests" to "anon";

grant delete on table "public"."report_requests" to "authenticated";

grant
insert
    on table "public"."report_requests" to "authenticated";

grant references on table "public"."report_requests" to "authenticated";

grant
select
    on table "public"."report_requests" to "authenticated";

grant trigger on table "public"."report_requests" to "authenticated";

grant truncate on table "public"."report_requests" to "authenticated";

grant
update
    on table "public"."report_requests" to "authenticated";

grant delete on table "public"."report_requests" to "service_role";

grant
insert
    on table "public"."report_requests" to "service_role";

grant references on table "public"."report_requests" to "service_role";

grant
select
    on table "public"."report_requests" to "service_role";

grant trigger on table "public"."report_requests" to "service_role";

grant truncate on table "public"."report_requests" to "service_role";

grant
update
    on table "public"."report_requests" to "service_role";

create policy "Deny all by default" on "public"."private_table" as restrictive for all to public using (false) with check (false);

create policy "Users access their own report requests only" on "public"."report_requests" as permissive for all to public using (
    (
        (
            SELECT
                auth.uid () AS uid
        ) = user_id
    )
) with check (
    (
        (
            SELECT
                auth.uid () AS uid
        ) = user_id
    )
);