class FullTextSearch1300370387 < ActiveRecord::Migration
  def self.up
    execute(<<-'eosql'.strip)
      DROP index IF EXISTS questions_fts_idx
    eosql
    execute(<<-'eosql'.strip)
      CREATE index questions_fts_idx
      ON questions
      USING gin((to_tsvector('english', coalesce("questions"."title", '') || ' ' || coalesce("questions"."body", ''))))
    eosql
  end

  def self.down
    execute(<<-'eosql'.strip)
      DROP index IF EXISTS questions_fts_idx
    eosql
  end
end
