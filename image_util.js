export const createCampaign = campaign => (
  $.ajax({
    method: 'POST',
    url: '/api/campaigns',
    data: {campaign}
  })
);
