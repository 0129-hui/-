CREATE DATABASE IF NOT EXISTS book_manage DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE book_manage;

DROP TABLE IF EXISTS borrow_record;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS sys_user;

CREATE TABLE sys_user (
    user_id     BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '用户ID',
    username    VARCHAR(50)  NOT NULL UNIQUE COMMENT '用户名',
    password    VARCHAR(100) NOT NULL COMMENT '密码',
    nickname    VARCHAR(50)  DEFAULT '' COMMENT '昵称',
    email       VARCHAR(100) DEFAULT '' COMMENT '邮箱',
    phone       VARCHAR(20)  DEFAULT '' COMMENT '手机号',
    sex         CHAR(1)      DEFAULT '0' COMMENT '性别(0未知 1男 2女)',
    avatar      VARCHAR(255) DEFAULT '' COMMENT '头像',
    role        VARCHAR(20)  DEFAULT 'user' COMMENT '角色(admin/user)',
    status      CHAR(1)      DEFAULT '0' COMMENT '状态(0正常 1停用)',
    create_time DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) COMMENT '用户表';

CREATE TABLE book (
    book_id     BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '图书ID',
    isbn        VARCHAR(20)  DEFAULT '' COMMENT 'ISBN编号',
    name        VARCHAR(200) NOT NULL COMMENT '书名',
    author      VARCHAR(100) DEFAULT '' COMMENT '作者',
    publisher   VARCHAR(200) DEFAULT '' COMMENT '出版社',
    category    VARCHAR(50)  DEFAULT '' COMMENT '分类',
    description TEXT         COMMENT '描述',
    cover       VARCHAR(255) DEFAULT '' COMMENT '封面',
    total       INT          DEFAULT 1 COMMENT '总数量',
    available   INT          DEFAULT 1 COMMENT '可借数量',
    status      CHAR(1)      DEFAULT '0' COMMENT '状态(0正常 1下架)',
    create_by   VARCHAR(50)  DEFAULT '' COMMENT '创建者',
    create_time DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) COMMENT '图书表';

CREATE TABLE borrow_record (
    record_id   BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '记录ID',
    book_id     BIGINT   NOT NULL COMMENT '图书ID',
    user_id     BIGINT   NOT NULL COMMENT '用户ID',
    borrow_date DATETIME NOT NULL COMMENT '借书日期',
    due_date    DATETIME NOT NULL COMMENT '应还日期',
    return_date DATETIME DEFAULT NULL COMMENT '还书日期',
    status      CHAR(1)  DEFAULT '0' COMMENT '状态(0借出 1已还 2逾期)',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) COMMENT '借阅记录表';

-- 默认密码: admin123 (BCrypt加密)
INSERT INTO sys_user (username, password, nickname, role, status) VALUES
('admin', '$2a$10$NV4krfmbwjn5nHv17HZHZeqx4mVvdrrsY118bE9fmICcBaIfe/LCq', '管理员', 'admin', '0'),
('user', '$2a$10$NV4krfmbwjn5nHv17HZHZeqx4mVvdrrsY118bE9fmICcBaIfe/LCq', '测试用户', 'user', '0');

INSERT INTO book (isbn, name, author, publisher, category, description, total, available) VALUES
('978-7-100-00001-1', '数据结构与算法', '严蔚敏', '清华大学出版社', '计算机', '经典数据结构教材', 5, 5),
('978-7-100-00002-2', '计算机网络', '谢希仁', '电子工业出版社', '计算机', '计算机网络基础教程', 3, 3),
('978-7-100-00003-3', '数据库系统概论', '王珊', '高等教育出版社', '计算机', '数据库原理教材', 4, 4);
