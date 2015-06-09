<?php namespace App\Http\Controllers\API;

use EFrane\Transfugio\Http\APIController;
use EFrane\Transfugio\Query\QueryService;
use EFrane\Transfugio\Query\ValueExpression;

class MembershipController extends APIController {
	protected $model = 'OParl\Membership';

  use \EFrane\Transfugio\Http\Method\IndexPaginatedTrait;
  use \EFrane\Transfugio\Http\Method\ShowItemTrait;

  protected function queryBody(QueryService &$query, ValueExpression $valueExpression)
  {
    $where = "(select count(*) from people where body_id {$valueExpression->getExpression()} ? and id = memberships.person_id)";

    $query->whereRaw($where, [$valueExpression->getValue()]);
  }
}
