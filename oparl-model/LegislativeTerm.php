<?php namespace OParl;

class LegislativeTerm extends BaseModel {

  protected $dates = ['start_date', 'end_date'];

  /**
   * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
   **/
  public function body()
  {
    return $this->belongsTo('OParl\Body');
  }

}
