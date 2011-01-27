CREATE TABLE "addresses" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "country_id" integer, "region_id" integer, "city" varchar(255), "zip" varchar(255), "street" varchar(255), "street_number" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "contacts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "phone" varchar(255), "mobile" varchar(255), "email" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "countries" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "fips104" varchar(2) NOT NULL, "iso2" varchar(2) NOT NULL, "iso3" varchar(3) NOT NULL, "ison" varchar(4) NOT NULL, "internet" varchar(2) NOT NULL, "capital" varchar(25), "map_reference" varchar(50), "nationality_singular" varchar(35), "nationaiity_plural" varchar(35), "currency" varchar(30), "currency_code" varchar(3), "population" integer, "title" varchar(50), "comment" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "email_acknowledgements" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "token" varchar(255), "expire_date" datetime, "ack_state" varchar(255), "email_acknowledgeable_id" integer, "email_acknowledgeable_type" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "organisations" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "products" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "realm_id" integer, "user_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "projects" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime, "updated_at" datetime, "product_id" integer);
CREATE TABLE "projects_members" ("user_id" integer, "project_id" integer, "role_id" integer);
CREATE TABLE "realms" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "user_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "regions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "country_id" integer NOT NULL, "name" varchar(45) NOT NULL, "code" varchar(8) NOT NULL, "adm1code" varchar(4) NOT NULL, "country_ison" varchar(4) NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "user_profiles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "firstname" varchar(255), "lastname" varchar(255), "gender" varchar(255), "date_of_birth" date, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar(255), "salt" varchar(255), "encrypted_password" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_projects_members_on_project_id" ON "projects_members" ("project_id");
CREATE INDEX "index_projects_members_on_user_id" ON "projects_members" ("user_id");
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20101104075609');

INSERT INTO schema_migrations (version) VALUES ('20101108124759');

INSERT INTO schema_migrations (version) VALUES ('20101118084038');

INSERT INTO schema_migrations (version) VALUES ('20101118091320');

INSERT INTO schema_migrations (version) VALUES ('20101118091505');

INSERT INTO schema_migrations (version) VALUES ('20101127205434');

INSERT INTO schema_migrations (version) VALUES ('20101127210552');

INSERT INTO schema_migrations (version) VALUES ('20101127211849');

INSERT INTO schema_migrations (version) VALUES ('20101127212841');

INSERT INTO schema_migrations (version) VALUES ('20101127213018');

INSERT INTO schema_migrations (version) VALUES ('20110119161453');

INSERT INTO schema_migrations (version) VALUES ('20110119164919');

INSERT INTO schema_migrations (version) VALUES ('20110119170509');

INSERT INTO schema_migrations (version) VALUES ('20110119171126');