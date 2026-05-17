#!/usr/bin/env node

/**
 * Supabase 数据库连接测试脚本
 * 
 * 使用方法：
 * 1. 安装依赖：npm install pg
 * 2. 配置环境变量（在 .env 文件中或直接修改脚本）
 * 3. 运行：node test-supabase-connection.js
 */

const { Pool } = require('pg');

// 配置数据库连接
const config = {
  host: process.env.POSTGRES_HOST || 'db.xxxxxx.supabase.co',
  port: process.env.POSTGRES_PORT || 5432,
  database: process.env.POSTGRES_DATABASE || process.env.POSTGRES_DB || 'postgres',
  user: process.env.POSTGRES_USER || 'postgres',
  password: process.env.POSTGRES_PASSWORD || 'your-password',
  ssl: {
    rejectUnauthorized: false // Supabase 需要 SSL
  }
};

console.log('🔍 测试 Supabase 数据库连接...\n');
console.log('配置信息：');
console.log(`  Host: ${config.host}`);
console.log(`  Port: ${config.port}`);
console.log(`  Database: ${config.database}`);
console.log(`  User: ${config.user}`);
console.log('');

const pool = new Pool(config);

async function testConnection() {
  try {
    // 测试连接
    console.log('1️⃣ 测试数据库连接...');
    const client = await pool.connect();
    console.log('✅ 数据库连接成功！\n');

    // 测试查询
    console.log('2️⃣ 测试查询...');
    const result = await client.query('SELECT NOW()');
    console.log(`✅ 查询成功！当前时间：${result.rows[0].now}\n`);

    // 检查表是否存在
    console.log('3️⃣ 检查 Waline 表是否存在...');
    const tablesQuery = `
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public' 
        AND table_name IN ('wl_comment', 'wl_counter', 'wl_users')
    `;
    const tablesResult = await client.query(tablesQuery);
    
    const tableNames = tablesResult.rows.map(row => row.table_name);

    if (tableNames.length === 0) {
      console.log('❌ Waline 表不存在！\n');
      console.log('请运行以下 SQL 脚本创建表：');
      console.log('https://raw.githubusercontent.com/walinejs/waline/main/assets/waline.pgsql\n');
    } else {
      console.log(`✅ 找到 ${tableNames.length} 个 Waline 表：`);
      tableNames.forEach(tableName => {
        console.log(`   - ${tableName}`);
      });
      console.log('');
    }

    // 测试插入数据
    console.log('4️⃣ 测试插入数据...');
    if (tableNames.includes('wl_comment')) {
      const insertQuery = `
        INSERT INTO wl_comment (nick, mail, comment, url, status)
        VALUES ('测试用户', 'test@example.com', '这是一条测试评论', '/test', 'approved')
        RETURNING id
      `;
      const insertResult = await client.query(insertQuery);
      console.log(`✅ 插入成功！评论 ID：${insertResult.rows[0].id}\n`);

      // 删除测试数据
      console.log('5️⃣ 清理测试数据...');
      const deleteQuery = `DELETE FROM wl_comment WHERE id = ${insertResult.rows[0].id}`;
      await client.query(deleteQuery);
      console.log('✅ 清理完成！\n');
    }

    client.release();
    console.log('🎉 所有测试通过！数据库连接正常。');
    
  } catch (error) {
    console.error('❌ 测试失败！');
    console.error(`错误信息：${error.message}\n`);
    
    if (error.code === 'ECONNREFUSED') {
      console.log('可能的原因：');
      console.log('  1. 数据库地址不正确');
      console.log('  2. 数据库端口不正确');
      console.log('  3. 网络连接问题\n');
    } else if (error.code === '28P01') {
      console.log('可能的原因：');
      console.log('  1. 用户名不正确');
      console.log('  2. 密码不正确\n');
    } else if (error.code === '3D000') {
      console.log('可能的原因：');
      console.log('  1. 数据库名称不正确\n');
    }
    
    process.exit(1);
  } finally {
    await pool.end();
  }
}

testConnection();
