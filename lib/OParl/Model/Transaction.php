<?php namespace OParl\Model;

use Illuminate\Database\Eloquent\Model;

class Transaction extends Model
{
  protected $fillable = ['model', 'model_id', 'action'];
}