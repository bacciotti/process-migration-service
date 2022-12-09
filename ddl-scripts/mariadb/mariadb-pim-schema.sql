create sequence MIG_REP_ID_SEQ start with 1 increment by 50;
create sequence MIGRATION_ID_SEQ start with 1 increment by 50;
create sequence PLAN_ID_SEQ start with 1 increment by 50;

create table migration_report_logs (
    report_id bigint not null,
    log longtext
) engine=InnoDB;

create table migration_reports (
    id bigint not null,
    end_date datetime(6),
    migration_id bigint,
    process_instance_id bigint,
    start_date datetime(6),
    success bit,
    primary key (id)
) engine=InnoDB;

create table migrations (
    id bigint not null,
    cancelled_at datetime(6),
    created_at datetime(6),
    callback_url tinyblob,
    scheduled_start_time datetime(6),
    execution_type integer,
    kieServerId varchar(255),
    plan_id bigint,
    requester varchar(255),
    error_message longtext,
    finished_at datetime(6),
    started_at datetime(6),
    status integer,
    primary key (id)
) engine=InnoDB;

create table plan_mappings (
    plan_id bigint not null,
    target varchar(255),
    source varchar(255) not null,
    primary key (plan_id, source)
) engine=InnoDB;

create table plans (
    id bigint not null,
    description varchar(255),
    name varchar(255),
    source_container_id varchar(255),
    source_process_id varchar(255),
    target_container_id varchar(255),
    target_process_id varchar(255),
    primary key (id)
) engine=InnoDB;

create table process_instance_ids (
    migration_definition_id bigint not null,
    processInstanceIds bigint
) engine=InnoDB;

create index IDX_MigrationReports_Id on migration_reports (migration_id);

alter table migration_report_logs
    add constraint FKj8bsydiucvs2kygnscp1bt1wy
    foreign key (report_id)
    references migration_reports (id);

alter table plan_mappings
    add constraint FKk892t85t9vt1xe6vf9nqwgqoh
    foreign key (plan_id)
    references plans (id);

alter table process_instance_ids
    add constraint FKobucfuy73fgsmkncl9q2rv6ko
    foreign key (migration_definition_id)
    references migrations (id);
