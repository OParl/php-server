<?php namespace App\Console\Commands;

use Illuminate\Console\Command;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputArgument;

class Deploy extends Command {

	/**
	 * The console command name.
	 *
	 * @var string
	 */
	protected $name = 'deploy';

	/**
	 * The console command description.
	 *
	 * @var string
	 */
	protected $description = 'Run commands necessary to put the application in a usable state.';

	/**
	 * Create a new command instance.
	 *
	 * @return void
	 */
	public function __construct()
	{
		parent::__construct();
	}

	/**
	 * Execute the console command.
	 *
	 * @return mixed
	 */
	public function fire()
	{
		//
//    "php artisan clear-compiled",
//    "php artisan optimize",
//    "npm update",
//    "bower update --allow-root",
//    "gulp --production"
    if ($this->willRun())
    {
      $this->call('clear-compiled');
      $this->call('optimize');

      #exec('npm install');
      #exec('bower update --allow-root');
      exec('gulp --production');
    } else
    {
      $this->info('Use --force to run deploy commands in local mode.');
    }
	}

  protected function willRun()
  {
    return !$this->getLaravel()->environment('local') || $this->option('force');
  }

	/**
	 * Get the console command arguments.
	 *
	 * @return array
	 */
	protected function getOptions()
	{
		return [
      ['force', 'f', InputOption::VALUE_NONE, 'Force production mode.'],
    ];
	}

}
