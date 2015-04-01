<?php

use OParl\AgendaItem;

class AgendaItemsTableSeeder extends Seeder {
  public function run()
  {
    // create a ridiculous amount of agenda items
    foreach (range(1, 10000) as $i)
    {
      $agendaItem = AgendaItem::create([
        'consecutive_number' => base_convert($i, 10, 32),
        'name'               => static::$faker->words(static::$faker->numberBetween(3, 8)),
        'public'             => static::$faker->boolean(70),
        'result'             => static::$faker->optional(30)->words(static::$faker->numberBetween(6, 21)),
      ]);

      if (!is_null($agendaItem->result))
      {
        // TODO: agendaitem resolution file
      }
    }
  }
}