<?php namespace OParl;

class Paper extends BaseModel {
  protected $dates = ['published_date'];

  /**
   * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
   **/
  public function body()
  {
    return $this->belongsTo('OParl\Body');
  }

  /**
   * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
   **/
  public function relatedPapers()
  {
    return $this->belongsToMany('OParl\Paper', 'papers_related_papers', 'paper_id', 'related_id');
  }

  /**
   * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
   **/
  public function auxiliaryFiles()
  {
    return $this->belongsToMany('OParl\Paper', 'papers_auxiliary_files', 'paper_id', 'auxiliary_id');
  }

  /**
   * @return \Illuminate\Database\Eloquent\Relations\HasMany
   **/
  public function consultations()
  {
    return $this->hasMany('OParl\Consultation');
  }
}
