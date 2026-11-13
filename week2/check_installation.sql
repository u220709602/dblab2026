-- Week 2: MySQL kurulumunu doğrulama sorguları

SELECT VERSION();

SHOW DATABASES;

CREATE DATABASE IF NOT EXISTS dblab;
USE dblab;
SELECT DATABASE();
