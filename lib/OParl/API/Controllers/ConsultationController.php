<?php namespace OParl\API\Controllers;

use EFrane\Transfugio\Http\APIController;
use EFrane\Transfugio\Query\QueryService;
use EFrane\Transfugio\Query\ValueExpression;

/**
 * Request Consultations
 *
 * @package OParl\API\Controllers
 **/
class ConsultationController extends APIController {
	protected $model = 'OParl\Model\Consultation';

  use \EFrane\Transfugio\Http\Method\IndexPaginatedTrait;
  use \EFrane\Transfugio\Http\Method\ShowItemTrait;

  /**
   * Resolve Body queries
   *
   * @param QueryService $query
   * @param ValueExpression $valueExpression
   **/
  public function queryBody(QueryService $query, ValueExpression $valueExpression)
  {
    // technically, consultations are linked to organizations, so that should be a way
    // to access body_id-s
  }
}
