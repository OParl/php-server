<?php namespace OParl\API\Transformers;

use OParl\Model\Person;
use OParl\Model\Membership;
use EFrane\Transfugio\Transformers\BaseTransformer;

class PersonTransformer extends BaseTransformer
{
  protected $availableIncludes = ['body', 'membership'];

  public function transform(Person $person)
  {
    return [
      'id'            => route('api.v1.person.show', $person->id),
      'type'          => 'http://oparl.org/schema/1.0/Person',
      'body'          => route('api.v1.body.show', $person->body->id),
      'name'          => $person->name,
      'familyName'    => $person->family_name,
      'givenName'     => $person->given_name,
      'title'         => explode(' ', $person->title),
      'formOfAddress' => $person->form_of_address,
      'gender'        => $person->gender,
      'email'         => $this->formatEmail($person->email),
      'phone'         => $this->formatPhoneNumber($person->phone),
      'streetAddress' => $person->street_address,
      'postalCode'    => $person->postal_code,
      'locality'      => $person->locality,
      'status'        => $person->status,
      'membership'    => route_where('api.v1.membership.index', ['person' => $person->id]),
      'keyword'       => $person->keyword,
      'created'       => $this->formatDate($person->created_at),
      'modified'      => $this->formatDate($person->updated_at)
    ];
  }

  public function includeBody(Person $person)
  {
    return $this->item($person->body, new BodyTransformer);
  }

  public function includeMembership(Person $person)
  {
    return $this->collection(Membership::where('person_id', '=', $person->id)->get(), new MembershipTransformer);
  }
}